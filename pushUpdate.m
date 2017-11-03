function pushLoad(~,~,guiCS)
%pushUpdate Updates the MIP channel shift display
% 
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %% Load the structure and assign variables
    tic
    structParameters = getappdata(guiCS,'structParameters');
    
    pathDir = strcat(structParameters.pathDir,'\');
    ch0Name = structParameters.ch0Name;
    ch1Name = structParameters.ch1Name;
    
    %%
    ch0Stack = openTIFF(pathDir,ch0Name);
    ch1Stack = openTIFF(pathDir,ch1Name);
    
    dimensions = size(ch0Stack);
    structParameters.dimensions = dimensions;
    
    [xyCh0,xzCh0,yzCh0] = makeMIPs(ch0Stack);
    [xyCh1,xzCh1,yzCh1] = makeMIPs(ch1Stack);
    
    maxCh0 = double(max(max(xyCh0)));
    minCh0 = double(min(min(xyCh0)));
    maxCh1 = double(max(max(xyCh1)));
    minCh1 = double(min(min(xyCh1)));
    
    xyCh0 = double(xyCh0);
    xzCh0 = double(xzCh0);
    yzCh0 = double(yzCh0);
    xyCh1 = double(xyCh1);
    xzCh1 = double(xzCh1);
    yzCh1 = double(yzCh1);
    
    xyCh0 = xyCh0 - minCh0;
    xyCh0 = xyCh0 ./ maxCh0;
    xzCh0 = xzCh0 - minCh0;
    xzCh0 = xzCh0 ./ maxCh0;
    yzCh0 = yzCh0 - minCh0;
    yzCh0 = yzCh0 ./ maxCh0;
    
    xyCh1 = xyCh1 - minCh1;
    xyCh1 = xyCh1 ./ maxCh1;
    xzCh1 = xzCh1 - minCh1;
    xzCh1 = xzCh1 ./ maxCh1;
    yzCh1 = yzCh1 - minCh1;
    yzCh1 = yzCh1 ./ maxCh1;
%     
%     
%     xyCh0 = imadjust(xyCh0,[0.0;Ch0ContrastValue],[]);
%     xzCh0 = imadjust(xzCh0,[0.0;Ch0ContrastValue],[]);
%     yzCh0 = imadjust(yzCh0,[0.0;Ch0ContrastValue],[]);
%     
    structParameters.xyCh0 = xyCh0;
    structParameters.xzCh0 = xzCh0;
    structParameters.yzCh0 = yzCh0;
%     
%     xyCh1 = imadjust(xyCh1,[0.0;Ch1ContrastValue],[]);
%     xzCh1 = imadjust(xzCh1,[0.0;Ch1ContrastValue],[]);
%     yzCh1 = imadjust(yzCh1,[0.0;Ch1ContrastValue],[]);
% 
    structParameters.xyCh1 = xyCh1;
    structParameters.xzCh1 = xzCh1;
    structParameters.yzCh1 = yzCh1;
    
%     axes1 = axes('Parent',guiCS,'Position',[0.400 0.60 0.35 0.310]);
%     structParameters.axes1 = axes1;
    setappdata(guiCS,'structParameters',structParameters');
%     
%     axes1 = axes('Parent',guiCS,'Position',[0.400 0.50 0.350 0.4]);
%     axes2 = axes('Parent',guiCS,'Position',[0.400 0.20 0.35 0.2]);
%     axes3 = axes('Parent',guiCS,'Position',[0.800 0.50 0.17 0.4]);
%     
%     xy = imfuse(xyCh0,xyCh1,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
%     %xy = xyCh0;
%     imagesc(xy,'Parent',axes1);
%     xlabel(axes1,'Pixels (x)');
%     ylabel(axes1,'Pixels (y)');
%     title(axes1,'MIP xy','Color','w','FontSize',14);
%     set(axes1,'YColor',[1 1 1],'XColor',[1 1 1]);
%     
%     xz = imfuse(xzCh0,xzCh1,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
%     imagesc(xz,'Parent',axes2);
%     xlabel(axes2,'Pixels (x)');
%     ylabel(axes2,'Pixels (z)');
%     title(axes2,'MIP xz','Color','w','FontSize',14);
%     set(axes2,'YColor',[1 1 1],'XColor',[1 1 1]);
%     set(axes2,'YDir','normal');
%     
%     yz = imfuse(yzCh0,yzCh1,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
%     imagesc(yz,'Parent',axes3);
%     xlabel(axes3,'Pixels (y)');
%     ylabel(axes3,'Pixels (z)');
%     title(axes3,'MIP yz','Color','w','FontSize',14);
%     set(axes3,'YColor',[1 1 1],'XColor',[1 1 1]);
%     set(axes3,'YDir','normal');

    disp('Ready')

end % pushLoad

