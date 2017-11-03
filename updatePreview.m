function updatePreview(guiCS)
%updatePreview Replots all the data into the GUI.
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017
    
    %%
    structParameters = getappdata(guiCS,'structParameters');
    structOffset = getappdata(guiCS,'structOffset');
    
    dimensions = structParameters.dimensions;
    
    xMin = structParameters.xMin;
    yMin = structParameters.yMin;
    zMin = structParameters.zMin;
    
    xMax = structParameters.xMax;
    yMax = structParameters.yMax;
    zMax = structParameters.zMax;
    
    axes1 = structParameters.axes1;
    axes2 = structParameters.axes2;
    axes3 = structParameters.axes3;
    
    %% Simpler error handling
    fileLoad = isfield(structParameters,'fileMIPs');
    if fileLoad == 0
        disp('No files loaded. Cannot display MIPs.');
        return
    end
    
    %% Normalizes the overlay and adjusts contrast from user input
    xyCh0 = imadjust(structParameters.fileMIPs.xy{1},[0.0;structParameters.Ch0ContrastValue],[]);
    xzCh0 = imadjust(structParameters.fileMIPs.xz{1},[0.0;structParameters.Ch0ContrastValue],[]);
    yzCh0 = imadjust(structParameters.fileMIPs.yz{1},[0.0;structParameters.Ch0ContrastValue],[]);
    
    xyChX = imadjust(structParameters.fileMIPs.xy{structParameters.cc},[0.0;structParameters.ChXContrastValue],[]);
    xzChX = imadjust(structParameters.fileMIPs.xz{structParameters.cc},[0.0;structParameters.ChXContrastValue],[]);
    yzChX = imadjust(structParameters.fileMIPs.yz{structParameters.cc},[0.0;structParameters.ChXContrastValue],[]);
    
    %% Pull out the correct offset
    channelName = strcat('ch',num2str(structParameters.cc)-1);
    xShift = int16(structOffset.(channelName).x);
    yShift = int16(structOffset.(channelName).y);
    zShift = int16(structOffset.(channelName).z);
    %% Shifts the second channel by the user input
    % xy
    xyChxNew = zeros(dimensions(1),dimensions(2));
    if xShift >= 0 && yShift >=0
        for jj = 1:dimensions(1) - abs(yShift)          
            for kk = 1:dimensions(2) - abs(xShift)
                xyChxNew(jj+yShift,kk+xShift) = xyChX(jj,kk);
            end % for
        end % for
    elseif xShift < 0 && yShift < 0
        for jj = 1:dimensions(1) - abs(yShift)
            for kk = 1:dimensions(2) - abs(xShift)
                xyChxNew(jj,kk) = xyChX(jj+abs(yShift),kk+abs(xShift));
            end % for
        end % for
    elseif xShift >= 0 && yShift < 0
        for jj = 1:dimensions(1) - abs(yShift)
            for kk = 1:dimensions(2) - abs(xShift)
                xyChxNew(jj,kk+abs(xShift)) = xyChX(jj+abs(yShift),kk);
            end % for
        end % for
    else
        for jj = 1:dimensions(1) - abs(yShift)
            for kk = 1:dimensions(2) - abs(xShift)
                xyChxNew(jj+abs(yShift),kk) = xyChX(jj,kk+abs(xShift));
            end % for
        end % for
        
    end % if
    
    % xz
    xzChxNew = zeros(dimensions(3),dimensions(2));
    if xShift >= 0 && zShift >= 0 
        for kk = 1:dimensions(2) - abs(xShift)
            for ii = 1:dimensions(3) - abs(zShift)
                xzChxNew(ii+zShift,kk+xShift) = xzChX(ii,kk);
            end % for
        end % for
    elseif xShift < 0 && zShift < 0 
        for kk = 1:dimensions(2) - abs(xShift)
            for ii = 1:dimensions(3) - abs(zShift)
                xzChxNew(ii,kk) = xzChX(ii+abs(zShift),kk+abs(xShift));
            end % for
        end % for
    elseif xShift >= 0 && zShift < 0 
        for kk = 1:dimensions(2) - abs(xShift)
            for ii = 1:dimensions(3) - abs(zShift)
                xzChxNew(ii,kk+abs(xShift)) = xzChX(ii+abs(zShift),kk);
            end % for
        end % for
    else
        for kk = 1:dimensions(2) - abs(xShift)
            for ii = 1:dimensions(3) - abs(zShift)
                xzChxNew(ii+abs(zShift),kk) = xzChX(ii,kk+abs(xShift));
            end % for
        end % for   
    end % if
    
    % yz
    yzChxNew = zeros(dimensions(1),dimensions(3));
    if yShift >= 0 && zShift >= 0
        for jj = 1:dimensions(1) - abs(yShift)
            for ii = 1:dimensions(3) - abs(zShift)
                yzChxNew(jj+yShift,ii+zShift) = yzChX(jj,ii);
            end % for
        end % for
    elseif yShift < 0 && zShift < 0
        for jj = 1:dimensions(1) - abs(yShift)
            for ii = 1:dimensions(3) - abs(zShift)
                yzChxNew(jj,ii) = yzChX(jj+abs(yShift),ii+abs(zShift));
            end % for
        end % for
    elseif yShift >= 0 && zShift < 0
        for jj = 1:dimensions(1) - abs(yShift)
            for ii = 1:dimensions(3) - abs(zShift)
                yzChxNew(jj+abs(yShift),ii) = yzChX(jj,ii+abs(zShift));
            end % for
        end % for
    else
        for jj = 1:dimensions(1) - abs(yShift)
            for ii = 1:dimensions(3) - abs(zShift)
                yzChxNew(jj,ii+abs(zShift)) = yzChX(jj+abs(yShift),ii);
            end % for
        end % for
        
    end % if
    
    % Re-plots all the data into the axes taking into account the varios
    % user inputs from the GUI
    xy = imfuse(xyCh0,xyChxNew,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    imagesc(xy,'Parent',axes1);
    ylabel(axes1,'Pixels (y)');
    xlim(axes1,[xMin xMax]);
    ylim(axes1,[yMin yMax]);
    title(axes1,'MIP xy','Color','w','FontSize',14);
    set(axes1,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(axes1,'DataAspectRatio',[1 1 1]);

    
    xz = imfuse(xzCh0,xzChxNew,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    imagesc(xz,'Parent',axes2);
    xlabel(axes2,'Pixels (x)');
    ylabel(axes2,'Pixels (z)');
    xlim(axes2,[xMin xMax]);
    ylim(axes2,[zMin zMax]);
    title(axes2,'MIP xz','Color','w','FontSize',14);
    set(axes2,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(axes2,'DataAspectRatio',[1 1 1]);
    set(axes2,'YDir','normal');

    
    yz = imfuse(yzCh0,yzChxNew,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    imagesc(yz,'Parent',axes3);
    xlabel(axes3,'Pixels (z)');
    ylabel(axes3,'Pixels (y)');
    xlim(axes3,[zMin zMax]);
    ylim(axes3,[yMin yMax]);
    title(axes3,'MIP yz','Color','w','FontSize',14);
    set(axes3,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(axes3,'DataAspectRatio',[1 1 1]);
    set(axes3,'YDir','reverse');
    set(axes3,'XDir','reverse');
    set(axes3,'YAxisLocation','right');

    
end % updatePreview

