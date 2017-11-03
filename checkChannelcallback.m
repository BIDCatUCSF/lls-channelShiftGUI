function checkChannelcallback(check,~,guiCS)
%checkChannelcallback Allows the user to change which channel is displayed
%against ch0. R2015b
% 
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %%
    structParameters = getappdata(guiCS,'structParameters');
    checkTag = get(check,'Tag');
    
    for ii = 1:5
        structParameters.channelCheck{ii} = 0;
    end % for
    
    structParameters.channelCheck{str2num(checkTag)} = 1;
    setappdata(guiCS,'structParameters',structParameters);
%     checkCh1.Value = structParameters.channelCheck{1};
%     checkCh2.Value = structParameters.channelCheck{2};
%     checkCh3.Value = structParameters.channelCheck{3};
%     checkCh4.Value = structParameters.channelCheck{4};
%     checkCh5.Value = structParameters.channelCheck{5};
%     updatePreview(guiCS);

end % checkChannelcallback

