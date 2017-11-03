function pushLoad(~,~,guiCS,buttonGroup,panelDisplay)
%pushLoad Loads the files, and creates the MIPs for the display. R2015b
% 
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %% Load the structure and assign some variables
    structParameters = getappdata(guiCS,'structParameters');
    
    pathDir = strcat(structParameters.pathDir,'\');
    axes1 = structParameters.axes1;
    axes2 = structParameters.axes2;
    axes3 = structParameters.axes3;

    
    %%
    % Get button ID
    buttonID = get(get(buttonGroup,'SelectedObject'),'Tag');
    switch buttonID
        case 'ch1'
            if isempty(structParameters.fileNames{2}) == 0
                structParameters.cc = 2;
                disp('Loading...');
            else
                disp('Choose another channel');
                return
            end % if
        case 'ch2'
            if isempty(structParameters.fileNames{3}) == 0
                structParameters.cc = 3;
                disp('Loading...');
            else
                disp('Choose another channel');
                return
            end % if
        case 'ch3'
            if isempty(structParameters.fileNames{4}) == 0
                structParameters.cc = 4;
                disp('Loading...');
            else
                disp('Choose another channel');
                return
            end % if
        case 'ch4'
            if isempty(structParameters.fileNames{5}) == 0
                structParameters.cc = 5;
                disp('Loading...');
            else
                disp('Choose another channel');
                return
            end % if
        case 'ch5'
            if isempty(structParameters.fileNames{6}) == 0
                structParameters.cc = 6;
                disp('Loading...');
            else
                disp('Choose another channel');
                return
            end % if
    end % switch
    
    % Load files and create the MIPs
    for ii = 1:6
        if isempty(structParameters.fileNames{ii}) == 0
            structParameters.fileStack{ii} = openTIFF(pathDir,structParameters.fileNames{ii});
            structParameters.channelMax{ii} = double(max(max(max(structParameters.fileStack{ii}))));
            structParameters.channelMin{ii} = double(min(min(min(structParameters.fileStack{ii}))));
            [structParameters.fileMIPs.xy{ii},structParameters.fileMIPs.xz{ii},structParameters.fileMIPs.yz{ii}] = makeMIPs(structParameters.fileStack{ii});
        end
    end
    
    % Get dimensions and load them in the structure
    dimensions = size(structParameters.fileStack{1});
    structParameters.dimensions = dimensions;
    structParameters.xMin = 1;
    structParameters.yMin = 1;
    structParameters.zMin = 1;
    structParameters.xMax = dimensions(2);
    structParameters.yMax = dimensions(1);
    structParameters.zMax = dimensions(3);
    % Normalize the MIPs
    for qq = 1:6
        if isempty(structParameters.fileNames{qq}) == 0
            structParameters.fileMIPs.xy{qq} = structParameters.fileMIPs.xy{qq} - structParameters.channelMin{qq};
            structParameters.fileMIPs.xy{qq} = structParameters.fileMIPs.xy{qq} ./ structParameters.channelMax{qq};
            structParameters.fileMIPs.xz{qq} = structParameters.fileMIPs.xz{qq} - structParameters.channelMin{qq};
            structParameters.fileMIPs.xz{qq} = structParameters.fileMIPs.xz{qq} ./ structParameters.channelMax{qq};
            structParameters.fileMIPs.yz{qq} = structParameters.fileMIPs.yz{qq} - structParameters.channelMin{qq};
            structParameters.fileMIPs.yz{qq} = structParameters.fileMIPs.yz{qq} ./ structParameters.channelMax{qq};
        end
    end
    
    % Initial MIPs overlay
    xyCh0 = imadjust(structParameters.fileMIPs.xy{1},[0.0;structParameters.Ch0ContrastValue],[]);
    xzCh0 = imadjust(structParameters.fileMIPs.xz{1},[0.0;structParameters.Ch0ContrastValue],[]);
    yzCh0 = imadjust(structParameters.fileMIPs.yz{1},[0.0;structParameters.Ch0ContrastValue],[]);
    
    xyChX = imadjust(structParameters.fileMIPs.xy{structParameters.cc},[0.0;structParameters.ChXContrastValue],[]);
    xzChX = imadjust(structParameters.fileMIPs.xz{structParameters.cc},[0.0;structParameters.ChXContrastValue],[]);
    yzChX = imadjust(structParameters.fileMIPs.yz{structParameters.cc},[0.0;structParameters.ChXContrastValue],[]);
    
    % Plot the first overlay without any of the other inputs
    xy = imfuse(xyCh0,xyChX,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    imagesc(xy,'Parent',axes1);
    ylabel(axes1,'Pixels (y)');
    xlim(axes1,[structParameters.xMin structParameters.xMax]);
    ylim(axes1,[structParameters.yMin structParameters.yMax]);
    title(axes1,'MIP xy','Color','w','FontSize',14);
    set(axes1,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(axes1,'DataAspectRatio',[1 1 1]);
    axis tight
    
    xz = imfuse(xzCh0,xzChX,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    imagesc(xz,'Parent',axes2);
    xlabel(axes2,'Pixels (x)');
    ylabel(axes2,'Pixels (z)');
    xlim(axes2,[structParameters.xMin structParameters.xMax]);
    ylim(axes2,[structParameters.zMin structParameters.zMax]);
    title(axes2,'MIP xz','Color','w','FontSize',14);
    set(axes2,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(axes2,'DataAspectRatio',[1 1 1]);
    set(axes2,'YDir','normal');
    axis tight
    
    yz = imfuse(yzCh0,yzChX,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
    imagesc(yz,'Parent',axes3);
    xlabel(axes3,'Pixels (z)');
    ylabel(axes3,'Pixels (y)');
    xlim(axes3,[structParameters.zMin structParameters.zMax]);
    ylim(axes3,[structParameters.yMin structParameters.yMax]);
    title(axes3,'MIP yz','Color','w','FontSize',14);
    set(axes3,'YColor',[1 1 1],'XColor',[1 1 1]);
    set(axes3,'DataAspectRatio',[1 1 1]);
    set(axes3,'YDir','reverse');
    set(axes3,'XDir','reverse');
    set(axes3,'YAxisLocation','right');
    axis tight
    
    % Load up the display ROI with the max and min values for all
    % dimensions
    editXmin = mycontrol(...
        'BackgroundColor',[0.1 0.1 0.44],...
        'ForegroundColor',[0.53 0.80 0.98],...
        'FontSize',10,...
        'Parent',panelDisplay,...
        'Position',[30 90 35 20],...
        'Style','edit',...
        'String',structParameters.xMin,...
        'Tag','editXmin',...
        'TooltipString','Time per Frame');
    set(editXmin.Handle,'Callback',{@editROIcallback,editXmin,guiCS})
    
    editXmax = mycontrol(...
        'BackgroundColor',[0.1 0.1 0.44],...
        'ForegroundColor',[0.53 0.80 0.98],...
        'FontSize',10,...
        'Parent',panelDisplay,...
        'Position',[80 90 35 20],...
        'Style','edit',...
        'String',structParameters.xMax,...
        'Tag','editXmax',...
        'TooltipString','Time per Frame');
    set(editXmax.Handle,'Callback',{@editROIcallback,editXmax,guiCS})
    
    editYmin = mycontrol(...
        'BackgroundColor',[0.1 0.1 0.44],...
        'ForegroundColor',[0.53 0.80 0.98],...
        'FontSize',10,...
        'Parent',panelDisplay,...
        'Position',[30 55 35 20],...
        'Style','edit',...
        'String',structParameters.yMin,...
        'Tag','editYmin',...
        'TooltipString','Time per Frame');
    set(editYmin.Handle,'Callback',{@editROIcallback,editYmin,guiCS})
    
    editYmax = mycontrol(...
        'BackgroundColor',[0.1 0.1 0.44],...
        'ForegroundColor',[0.53 0.80 0.98],...
        'FontSize',10,...
        'Parent',panelDisplay,...
        'Position',[80 55 35 20],...
        'Style','edit',...
        'String',structParameters.yMax,...
        'Tag','editYmax',...
        'TooltipString','Time per Frame');
    set(editYmax.Handle,'Callback',{@editROIcallback,editYmax,guiCS})
    
    editZmin = mycontrol(...
        'BackgroundColor',[0.1 0.1 0.44],...
        'ForegroundColor',[0.53 0.80 0.98],...
        'FontSize',10,...
        'Parent',panelDisplay,...
        'Position',[30 20 35 20],...
        'Style','edit',...
        'String',structParameters.zMin,...
        'Tag','editZmin',...
        'TooltipString','Time per Frame');
    set(editZmin.Handle,'Callback',{@editROIcallback,editZmin,guiCS})
    
    editZmax = mycontrol(...
        'BackgroundColor',[0.1 0.1 0.44],...
        'ForegroundColor',[0.53 0.80 0.98],...
        'FontSize',10,...
        'Parent',panelDisplay,...
        'Position',[80 20 35 20],...
        'Style','edit',...
        'String',structParameters.zMax,...
        'Tag','editZmax',...
        'TooltipString','Time per Frame');
    set(editZmax.Handle,'Callback',{@editROIcallback,editZmax,guiCS})

    % Set all app data
    setappdata(guiCS,'structParameters',structParameters');

    disp('Ready')

end % pushLoad

