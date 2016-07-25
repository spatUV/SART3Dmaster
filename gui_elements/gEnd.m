function gEnd(src,callbackdata)
% Close request function 
% to display a question dialog box 
   selection = questdlg('Close SART3D?',...
      'Leave SART3D',...
      'Yes','No','Yes'); 
   switch selection, 
      case 'Yes',
         %delete(gcf)
         figHandles = findobj('Type','figure');
         delete(figHandles);
      case 'No'
      return 
   end
end