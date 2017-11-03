function pushCrop(~,~,guiCS)
%pushCrop Crops the files in the directory based on the offsets in the GUI.
%R2015b
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017
    %%
    structParameters = getappdata(guiCS,'structParameters');
    structOffset = getappdata(guiCS,'structOffset');
    
    xcMin = structParameters.xcMin;
    xcMax = structParameters.xcMax;
    ycMin = structParameters.ycMin;
    ycMax = structParameters.ycMax;
    zcMin = structParameters.zcMin;
    zcMax = structParameters.zcMax;

    pathDir = strcat(structParameters.pathDir,'\');
    newFolder = 'CroppedFiles';
    
    mkdir(pathDir,newFolder);
    finaloutpath = strcat(pathDir,newFolder,'\');
    
    %%
    fnames = dir(fullfile(pathDir,'*tif'));
    fnames = {fnames.name}.';
    % Find function based on regular expressions
    FIND = @(str) cellfun(@(c)~isempty(c),regexp(fnames,str,'once'));
    
    for cc = 0:5
        if isempty(structParameters.fileNames{cc+1}) == 0
            regexp_channel = strcat('_ch',int2str(cc),'_');
            channel_subset{:,cc+1} = fnames(FIND(regexp_channel));
            
        end % if
    end % for
    
    for pp = 1:length(channel_subset)
        if pp == 1
            xShift = 0;
            yShift = 0;
            zShift = 0;
        else
            chName = strcat('ch',num2str(pp)-1);
            xShift = structOffset.(chName).x;
            yShift = structOffset.(chName).y;
            zShift = structOffset.(chName).z;
        end % if
        for ff = 1:length(channel_subset{:,pp})
            fileName = char(channel_subset{1,pp}{ff,1});
            disp(fileName);
            fileStack = openTIFF(pathDir,fileName);
            c = 'uint16';
            
            cropStack = zeros((ycMax-ycMin+1),(xcMax-xcMin+1),(zcMax-zcMin+1),c);
            for ii = 1:(zcMax-zcMin+1)
                for jj = 1:(ycMax-ycMin+1)
                    for kk = 1:(xcMax-xcMin+1)
                        cropStack(jj,kk,ii) = fileStack(jj+ycMin-1-yShift,kk+xcMin-1-xShift,ii+zcMin-1-zShift);
                    end % for
                end % for
            end % for
            writeTiff(cropStack,strcat(finaloutpath,fileName));
        end % for
    end % for
            

end %pushCrop

