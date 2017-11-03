function [xyMIP,xzMIP,yzMIP] = makeMIPs( fileStack)
%makeMIPs Makes MIPs of a stack in 3 dimensions
%   Kyle Marchuk, March 2017

    %%
    dimensions = size(fileStack);
    xyMIP = zeros(dimensions(1),dimensions(2),1,'double');
    for jj = 1:dimensions(1)
        for kk = 1:dimensions(2)
            xyMIP(jj,kk) = max(fileStack(jj,kk,:));
        end % for
    end % for

    
    xzMIP = zeros(dimensions(3),dimensions(2),1,'double');
    for kk = 1:dimensions(2)
        for ii = 1:dimensions(3)
            xzMIP(ii,kk) =max(fileStack(:,kk,ii));
        end % for
    end % for

    
    yzMIP = zeros(dimensions(1),dimensions(3),1,'double');
    for jj = 1:dimensions(1)
        for ii = 1:dimensions(3)
            yzMIP(jj,ii) = max(fileStack(jj,:,ii));
        end % for
    end % for


end % makeMIPs

