function gDrawScene(bounds, view)
%%GDRAWSCENE places the sound scene objects in the corresponding axes
%specified by the dimensions BOUNDS, taking into acount if VIEW is
%'profile' or 'plan'

global conf;

%%
% Obtain distances to loudspeakers and get minimum and maximum
r = cellfun(@(x)x(1), conf.LS.coord);
rMin = min(r);
rMax = max(r);

%%
% Create axes. Size in pixels (depends on resolution)
ha = axes('Units', 'Pixels', 'Position', bounds);

%%
% Draw dot line around closest loudspeaker
angle = 0:0.1:2*pi;
xp = rMin*cos(angle);
yp = rMin*sin(angle);

%%
% Configure 'HitTest' to avoid selection:
plot(xp, yp, 'b.', 'MarkerSize', 5, 'HitTest', 'off');

% for ii=1:length(xp)
%     rectangle('Position',[xp(ii), yp(ii), 0.02, 0.02],'Curvature',[1 1],'FaceColor','Blue','EdgeColor','none');
% end

%%
% Change background color and set tag to manage with guihandles
color = [1 1 1]; % white
set(ha, 'color', color, 'tag', (['axes_' view]));

%%
% Draw listener in the center
GImage(gcf, '', bounds, (['guy_' view '.png']));

%%
% We take the loudspeaker angles:
angles_az = cellfun(@(x)x(2), conf.LS.coord); % Azimuth
angles_el = cellfun(@(x)x(3), conf.LS.coord); % Elevación
if strcmp(view, 'profile')
    % Rotate axes accordingly (y, z):
    set(ha, 'View', [90 0]);
end

%%
% Eliminate ticks from axis:
%set(ha, 'XTick', [], 'YTick', [], 'ZTick', []);
%set(ha, 'XTickLabel', [], 'YTickLabel', [], 'ZTickLabel', []);
set(ha,'XGrid','on', 'YGrid', 'on', 'ZGrid','on');

%%
% Set axis labels.
set(get(ha, 'XLabel'), 'String', 'x', 'FontWeight', 'bold');
set(get(ha, 'YLabel'), 'String', 'y', 'FontWeight', 'bold');
set(get(ha, 'ZLabel'), 'String', 'z', 'FontWeight', 'bold');

%%
% Manual limits:
set(ha, 'XLimMode', 'manual');
set(ha, 'YLimMode', 'manual');
set(ha, 'ZLimMode', 'manual');

%%
% Limits set from max loudspeaker distance
set(ha, 'XLim', [-conf.rmax, conf.rmax]);
set(ha, 'YLim', [-conf.rmax, conf.rmax]);
set(ha, 'ZLim', [-conf.rmax, conf.rmax]);
%xy_scale = bounds(3)/(4*rMax);
xy_scale = bounds(3)/(2*conf.rmax);
conf.axes.xy_scale = xy_scale;


% sc = 5;
% set(ha, 'XLim', [-sc*rMax, sc*rMax]);
% set(ha, 'YLim', [-sc*rMax, sc*rMax]);
% set(ha, 'ZLim', [-sc*rMax, sc*rMax]);
% %xy_scale = bounds(3)/(4*rMax);
% xy_scale = bounds(3)/(2*sc*rMax);
% conf.axes.xy_scale = xy_scale;

%%
% Titles
if strcmp(view, 'plan')
    set(get(ha, 'Title'), 'String', 'Plan View', 'FontWeight', 'bold');
else
    set(get(ha, 'Title'), 'String', 'Profile View', 'FontWeight', 'bold');
end

%%
% We initialize cell array with total number of loudspeakers
gImagesLS = {conf.nLS};

%%
% Draw loudspeakers.
% We go from last to first to have them all ordered in guihandles
for ii = conf.nLS:-1:1
    
    if strcmp(view, 'plan')
        horizontal = xy_scale*conf.LS.car(1,ii);
        vertical   = xy_scale*conf.LS.car(2,ii);
    elseif strcmp(view, 'profile')
        horizontal = xy_scale*conf.LS.car(2,ii);
        vertical   = xy_scale*conf.LS.car(3,ii);
    end
    gImagesLS{ii} = GImage(gcf, (['ls_' view '_' num2str(ii)]), bounds, 'ls.png');
    boundsLS = getBounds(gImagesLS{ii});
    
   
    setBounds(gImagesLS{ii},[bounds(1)-boundsLS(3)/2+horizontal+bounds(3)/2,bounds(2)-boundsLS(4)/2+vertical+bounds(4)/2,boundsLS(3),boundsLS(4)]);
    
    
    % Set loudspeaker number:
    setString(gImagesLS{ii}, ii);
    setForegroundColor(gImagesLS{ii}, 'w');
    setFontSize(gImagesLS{ii}, 5);
    
    % Delete tag to speed up
    setTag(gImagesLS{ii}, '');
   
end
%set(gca,'Color',[0.9412 0.9412 0.9412]);


end