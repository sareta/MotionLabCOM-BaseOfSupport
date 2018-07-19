% Read native G4 frames from a TCPIP socket, output (cells, per row) is:
% hub | frame | DigIO | sensor | pos ... | ori ...
function pno_data = g4client(host_str, port_num, seconds)

    % use java Socket and DataInputStream classes
    import java.net.Socket
    import java.io.*    
    
    % connect to the socket and open the data stream
    for attempt = 1:5
        try
            fprintf(1, 'Attempt #%d to connect...', attempt);
            socket = Socket(host_str, port_num);
            stream = socket.getInputStream;
            di_stream = DataInputStream(stream);
            fprintf(1, 'Success\n');
            break;
        catch
            fprintf(1, 'Failure\n');
            if ~isempty(socket)
                socket.close;
            end
            if attempt == 5
                error('Failed all attempts to connect');
            end
            pause(1);
        end % try
    end % for
    
    pno_data = {};
    
    % collect data and store it in the array
    t1 = tic;
    while toc(t1) < seconds
        try
            % read first 16 bytes
            raw_data = zeros(1, 4, 'single');
            for i=1:4
                raw_data(i) = single(di_stream.readFloat);
            end % for
            
            % swap bytes
            raw_data = swapbytes(raw_data);
            
            % typecast to uint32
            raw_data = typecast(raw_data, 'uint32');
            
            % for reference, split array
            nHubID = raw_data(1);
            nFrame = raw_data(2);
            dwSMap = raw_data(3);
            dwDgIO = raw_data(4);
            
            % parse sensor frames
            for i=1:3
                if bitget(dwSMap, i) ~= 0 % frame has data
                    % read sensor ID
                    nSenID = single(di_stream.readFloat);
                    
                    % swap bytes
                    nSenID = swapbytes(nSenID);
                    
                    % typecast to uint32
                    nSenID = typecast(nSenID, 'uint32');
                    
                    % initialize pno array
                    pno = zeros(1, 7, 'single');
                    
                    % read pno data
                    for j=1:7
                        pno(j) = single(di_stream.readFloat);
                    end % for
                    
                    % swap bytes
                    pno = swapbytes(pno);
                    
                    % create pno data row
                    pno_row = {nHubID nFrame dwDgIO nSenID pno(1) ...
                        pno(2) pno(3) pno(4) pno(5) pno(6) pno(7)};
                    
                    % append data row vector to matrix as new row
                    pno_data = cat(1, pno_data, pno_row);
                    
                else % frame has no data
                    % skip empty frame
                    tmp = zeros(1,32);
                    di_stream.read(tmp,0,32);
                    
                end % if
                    
            end % for
        catch err
            fprintf(1, err.message);
            break;
        end
    end
    
    % disconnect from the socket
    fprintf(1, 'Disconnected...\n');
    socket.close();
end