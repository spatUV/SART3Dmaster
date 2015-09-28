function setfigptr(pointer_name, fig)
% SETFIGPTR Set figure pointer.
%   SETFIGPTR(POINTER_NAME,FIG) sets the pointer of the figure with handle FIG 
%   according to the Pointer_name list. 
%
%   Note : if the FIG argument is ommitted, the function sets the pointer
%          of the current figure.
%
%   SETFIGPTR sets the pointer of the current figure to {arrow} shape.
%
%   Pointer_name list :
%        'hand'    - open hand for panning indication
%        'hand1'   - open hand with a 1 on the back
%        'hand2'   - open hand with a 2 on the back
%        'closedhand' - closed hand
%        'glass'   - magnifying glass
%        'lrdrag'  - left/right drag cursor
%        'ldrag'   - left drag cursor
%        'rdrag'   - right drag cursor
%        'uddrag'  - up/down drag cursor
%        'udrag'   - up drag cursor
%        'ddrag'   - down drag cursor
%        'add'     - arrow with + sign
%        'addzero' - arrow with 'o'
%        'addpole' - arrow with 'x'
%        'eraser'  - eraser
%        'help'    - arrow with question mark ?
%        'zoomin'  - magnifying glass with +
%        'zoomout'  - magnifying glass with -
%        'matlabdoc' - exemple of custom made pointer from the Matlab doc.
%        'none'    - no pointer
%        [ crosshair | fullcrosshair | {arrow} | ibeam | watch | topl | topr ...
%        | botl | botr | left | top | right | bottom | circle | cross | fleur ]
%             - standard figure cursors
%
%   See also GETFIGPTR, SWITCHFIGPTR

%   Author: Jérôme Briot, Aug 2005 
%   Revision #1: Aug 2006 - 4 new pointers added (zoomin,zoomout,matlabdoc,none)
%   Comments:
%       This is an enhancement of the SETPTR.M file.
%       (<MATLABROOT>\toolbox\matlab\uitools)
%       Author: T. Krauss, 10/95
%       Copyright 1984-2001 The MathWorks, Inc. 
%       $Revision: 1.15 $  $Date: 2001/04/15 12:03:33 $ 
%

error(nargchk(0, 2, nargin))

if nargin==0
    
    fig=gcf;
%     cdata=[];
    pointer_name='default';
    
elseif nargin==1
    
    if isa(pointer_name,'cell')
    
         set(gcf,pointer_name{:})
         return
         
     else fig=gcf;
         
     end    
    

else
    
%     error('Type "help setfigptr" for more informations');
    
end

% cdata=[];

switch lower(pointer_name)
    
   case 'add'
     cdata=[...
       2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2 NaN NaN NaN NaN NaN
       2   1   2 NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN
       2   1   1   2 NaN NaN NaN NaN   2   2   1   2   2 NaN NaN NaN
       2   1   1   1   2 NaN NaN   2   1   1   1   1   1   2 NaN NaN
       2   1   1   1   1   2 NaN NaN   2   2   1   2   2 NaN NaN NaN
       2   1   1   1   1   1   2 NaN NaN   2   1   2 NaN NaN NaN NaN
       2   1   1   1   1   1   1   2 NaN NaN   2 NaN NaN NaN NaN NaN
       2   1   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   2   2   2   2   2 NaN NaN NaN NaN NaN
       2   1   1   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN NaN
       2   1   2 NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2   2 NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2 NaN NaN NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN
    ];
       hotspot = [1 1];

   case 'addpole'
     cdata=[...
       2   2 NaN NaN NaN NaN NaN   2   2   2 NaN NaN   2   2 NaN NaN
       2   1   2 NaN NaN NaN NaN   2   1   2 NaN   2   1   2 NaN NaN
       2   1   1   2 NaN NaN NaN NaN   2   1   2   1   2   2 NaN NaN
       2   1   1   1   2 NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN
       2   1   1   1   1   2 NaN NaN   2   1   2   1   2   2 NaN NaN
       2   1   1   1   1   1   2   2   1   2 NaN   2   1   2 NaN NaN
       2   1   1   1   1   1   1   2   2 NaN NaN NaN   2   2 NaN NaN
       2   1   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   2   2   2   2   2 NaN NaN NaN NaN NaN
       2   1   1   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN NaN
       2   1   2 NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2   2 NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2 NaN NaN NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN
    ];
       hotspot = [1 1];

   case 'addzero'
     cdata=[...
       2   2 NaN NaN NaN NaN NaN NaN   2   2   2   2   2 NaN NaN NaN
       2   1   2 NaN NaN NaN NaN   2   2   1   1   1   2   2 NaN NaN
       2   1   1   2 NaN NaN NaN   2   1   2   2   2   1   2 NaN NaN
       2   1   1   1   2 NaN NaN   2   1   2 NaN   2   1   2 NaN NaN
       2   1   1   1   1   2 NaN   2   1   2   2   2   1   2 NaN NaN
       2   1   1   1   1   1   2   2   2   1   1   1   2   2 NaN NaN
       2   1   1   1   1   1   1   2   2   2   2   2   2 NaN NaN NaN
       2   1   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   2   2   2   2   2 NaN NaN NaN NaN NaN
       2   1   1   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN NaN
       2   1   2 NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2   2 NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2 NaN NaN NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN
    ];
       hotspot = [1 1];
                            
   case 'closedhand'
       cdata = [...
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN NaN   1   1 NaN   1   1 NaN   1   1 NaN NaN NaN NaN
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   1 NaN NaN
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   1   2   1 NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN NaN   1   1   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         ];
              hotspot = [8 8];    

  case 'eraser'
     cdata = [...  
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
       1   1   1   1   1   1   1 NaN NaN NaN NaN NaN NaN NaN NaN NaN
       1   1   2   2   2   2   2   1 NaN NaN NaN NaN NaN NaN NaN NaN
       1   2   1   2   2   2   2   2   1 NaN NaN NaN NaN NaN NaN NaN
       1   2   2   1   2   2   2   2   2   1 NaN NaN NaN NaN NaN NaN
     NaN   1   2   2   1   2   2   2   2   2   1 NaN NaN NaN NaN NaN
     NaN NaN   1   2   2   1   2   2   2   2   2   1 NaN NaN NaN NaN
     NaN NaN NaN   1   2   2   1   2   2   2   2   2   1 NaN NaN NaN
     NaN NaN NaN NaN   1   2   2   1   2   2   2   2   2   1 NaN NaN
     NaN NaN NaN NaN NaN   1   2   2   1   2   2   2   2   2   1 NaN
     NaN NaN NaN NaN NaN NaN   1   2   2   1   1   1   1   1   1   1
     NaN NaN NaN NaN NaN NaN NaN   1   2   1   2   2   2   2   2   1
     NaN NaN NaN NaN NaN NaN NaN NaN   1   1   1   1   1   1   1   1
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
    ];
       hotspot = [2 1];
       
   case 'forbidden'
       cdata = [...       
     NaN NaN NaN   2   2   1   1   1   1   1   2   2 NaN NaN NaN NaN
     NaN NaN   2   1   1   1   1   1   1   1   1   1   2 NaN NaN NaN
     NaN   2   1   1   1   2   2   2   2   2   1   1   1   2 NaN NaN
       2   1   1   1   2 NaN NaN NaN NaN   2   1   1   1   1   2 NaN
       2   1   1   2 NaN NaN NaN NaN   2   1   1   1   1   1   2   2
       1   1   2 NaN NaN NaN NaN   2   1   1   1   2   2   1   1   2
       1   1   2 NaN NaN NaN   2   1   1   1   2 NaN   2   1   1   2
       1   1   2 NaN NaN   2   1   1   1   2 NaN NaN   2   1   1   2
       1   1   2 NaN   2   1   1   1   2 NaN NaN NaN   2   1   1   2
       1   1   2   2   1   1   1   2 NaN NaN NaN NaN   2   1   1   2
       2   1   1   1   1   1   2 NaN NaN NaN NaN   2   1   1   2   2
       2   1   1   1   1   2 NaN NaN NaN NaN   2   1   1   1   2 NaN
     NaN   2   1   1   1   2   2   2   2   2   1   1   1   2 NaN NaN
     NaN NaN   2   1   1   1   1   1   1   1   1   1   2 NaN NaN NaN
     NaN NaN NaN   2   2   1   1   1   1   1   2   2 NaN NaN NaN NaN
     NaN NaN NaN NaN   2   2   2   2   2   2   2 NaN NaN NaN NaN NaN
     ];
       hotspot = [8 8];
       
   case 'glass'
       cdata = [...
         NaN NaN NaN NaN   1   1   1   1 NaN NaN NaN NaN NaN NaN NaN NaN
         NaN NaN   1   1 NaN   2 NaN   2   1   1 NaN NaN NaN NaN NaN NaN
         NaN   1   2 NaN   2 NaN   2 NaN   2 NaN   1 NaN NaN NaN NaN NaN
         NaN   1 NaN   2 NaN   2 NaN   2 NaN   2   1 NaN NaN NaN NaN NaN
           1 NaN   2 NaN   2 NaN   2 NaN   2 NaN   2   1 NaN NaN NaN NaN
           1   2 NaN   2 NaN   2 NaN   2 NaN   2 NaN   1 NaN NaN NaN NaN
           1 NaN   2 NaN   2 NaN   2 NaN   2 NaN   2   1 NaN NaN NaN NaN
           1   2 NaN   2 NaN   2 NaN   2 NaN   2 NaN   1 NaN NaN NaN NaN
         NaN   1   2 NaN   2 NaN   2 NaN   2 NaN   1 NaN NaN NaN NaN NaN
         NaN   1 NaN   2 NaN   2 NaN   2 NaN   2   1   2 NaN NaN NaN NaN
         NaN NaN   1   1   2 NaN   2 NaN   1   1   1   1   2 NaN NaN NaN
         NaN NaN NaN NaN   1   1   1   1 NaN   2   1   1   1   2 NaN NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   1   1   1   2 NaN
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   1   1   1   2
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   1   1   1
         NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   2   1   2
         ];
              hotspot = [7 7];          
       
   case 'hand'
       cdata = [...
         NaN NaN NaN NaN NaN NaN NaN   1   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN   1   1 NaN   1   2   2   1   1   1 NaN NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN   1 NaN
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   1   2   1
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   2   2   1
         NaN   1   1 NaN   1   2   2   2   2   2   2   2   1   2   2   1
           1   2   2   1   1   2   2   2   2   2   2   2   2   2   2   1
           1   2   2   2   1   2   2   2   2   2   2   2   2   2   1 NaN
         NaN   1   2   2   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN   1   2   2   2   2   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN   1   2   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         ];
              hotspot = [8 8];

   case 'hand1'
       cdata = [...
         NaN NaN NaN NaN NaN NaN NaN   1   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN   1   1 NaN   1   2   2   1   1   1 NaN NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN   1 NaN
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   1   2   1
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   2   2   1
         NaN   1   1 NaN   1   2   2   2   2   2   2   2   1   2   2   1
           1   2   2   1   1   2   2   2   1   2   2   2   2   2   2   1
           1   2   2   2   1   2   2   1   1   2   2   2   2   2   1 NaN
         NaN   1   2   2   2   2   2   2   1   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   1   2   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   1   2   2   2   2   1 NaN NaN
         NaN NaN NaN   1   2   2   2   2   1   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN   1   2   2   1   1   1   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         ];
              hotspot = [10 9];              
              
   case 'hand2'
       cdata = [...
         NaN NaN NaN NaN NaN NaN NaN   1   1 NaN NaN NaN NaN NaN NaN NaN
         NaN NaN NaN   1   1 NaN   1   2   2   1   1   1 NaN NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN NaN NaN
         NaN NaN   1   2   2   1   1   2   2   1   2   2   1 NaN   1 NaN
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   1   2   1
         NaN NaN NaN   1   2   2   1   2   2   1   2   2   1   2   2   1
         NaN   1   1 NaN   1   2   2   2   2   2   2   2   1   2   2   1
           1   2   2   1   1   2   2   2   1   1   2   2   2   2   2   1
           1   2   2   2   1   2   2   1   2   2   1   2   2   2   1 NaN
         NaN   1   2   2   2   2   2   2   2   2   1   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   2   1   2   2   2   2   1 NaN
         NaN NaN   1   2   2   2   2   2   1   2   2   2   2   1 NaN NaN
         NaN NaN NaN   1   2   2   2   1   2   2   2   2   2   1 NaN NaN
         NaN NaN NaN NaN   1   2   2   1   1   1   1   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         NaN NaN NaN NaN NaN   1   2   2   2   2   2   2   1 NaN NaN NaN
         ];
              hotspot = [10 9];              
              
    case 'help'       
       cdata = [...
       2   2 NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
       2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
       2   1   1   2 NaN NaN NaN NaN NaN   2   2   2   2   2 NaN NaN
       2   1   1   1   2 NaN NaN NaN   2   1   1   1   1   1   2 NaN
       2   1   1   1   1   2 NaN   2   1   1   1   1   1   1   1   2
       2   1   1   1   1   1   2   2   1   1   2   2   2   1   1   2
       2   1   1   1   1   1   1   2   1   1   2 NaN   2   1   1   2
       2   1   1   1   1   1   1   1   2   2 NaN   2   1   1   2 NaN
       2   1   1   1   1   1   1   1   1   2   2   1   1   2 NaN NaN
       2   1   1   1   1   1   2   2   2   2   1   1   2 NaN NaN NaN
       2   1   1   2   1   1   2 NaN NaN   2   1   1   2 NaN NaN NaN
       2   1   2 NaN   2   1   1   2 NaN   2   2   2   2 NaN NaN NaN
       2   2 NaN NaN   2   1   1   2 NaN   2   1   1   2 NaN NaN NaN
       2 NaN NaN NaN NaN   2   1   1   2   2   1   1   2 NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   2   2   2   2   2 NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [2 2];
       
   case 'lrdrag'
       cdata = [...
     NaN NaN NaN NaN NaN   2   2   2   2   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN   2   2   1   2   1   2   2 NaN NaN NaN NaN NaN
     NaN NaN NaN   2   1   2   1   2   1   2   1   2 NaN NaN NaN NaN
     NaN NaN   2   1   1   2   1   2   1   2   1   1   2 NaN NaN NaN
     NaN   2   1   1   1   1   1   2   1   1   1   1   1   2 NaN NaN
       2   1   1   1   1   1   1   2   1   1   1   1   1   1   2 NaN
     NaN   2   1   1   1   1   1   2   1   1   1   1   1   2 NaN NaN
     NaN NaN   2   1   1   2   1   2   1   2   1   1   2 NaN NaN NaN
     NaN NaN NaN   2   1   2   1   2   1   2   1   2 NaN NaN NaN NaN
     NaN NaN NaN NaN   2   2   1   2   1   2   2 NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   2   2   2   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [8 8];

   case 'ldrag'
       cdata = [...
     NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN   2   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN   2   1   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN   2   1   1   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN   2   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
       2   1   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN   2   1   1   1   1   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN   2   1   1   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN   2   1   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN   2   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [8 8];       
 
   case 'rdrag'
       cdata = [...
     NaN NaN NaN NaN NaN NaN NaN NaN   2   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2   2 NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1   2 NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1   1   2 NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   1   1   1   1   2 NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   1   1   1   1   1   2 NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   1   1   1   1   2 NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1   1   2 NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1   2 NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2   2 NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN   2   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [8 8];   
       
   case 'uddrag'
       cdata = [...
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN   2   1   1   1   1   1   2 NaN NaN NaN NaN NaN
     NaN NaN NaN   2   1   1   1   1   1   1   1   2 NaN NaN NaN NaN
       2   2   2   2   2   2   1   1   1   2   2   2   2   2   2 NaN
       2   1   1   1   1   1   1   1   1   1   1   1   1   1   2 NaN
       2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 NaN
       2   1   1   1   1   1   1   1   1   1   1   1   1   1   2 NaN
       2   2   2   2   2   2   1   1   1   2   2   2   2   2   2 NaN
     NaN NaN NaN   2   1   1   1   1   1   1   1   2 NaN NaN NaN NaN
     NaN NaN NaN NaN   2   1   1   1   1   1   2 NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN   2 NaN NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [9 8];       
       
   case 'udrag'
       cdata = [...
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN   2 NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   1   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   1   1   1   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN   2   1   1   1   1   1   2 NaN NaN NaN NaN NaN
     NaN NaN NaN   2   1   1   1   1   1   1   1   2 NaN NaN NaN NaN
       2   2   2   2   2   2   1   1   1   2   2   2   2   2   2 NaN
       2   1   1   1   1   1   1   1   1   1   1   1   1   1   2 NaN
       2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [9 8];        

   case 'ddrag'
       cdata = [...
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
       2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 NaN
       2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 NaN
       2   2   2   2   2   2   2   2   2   2   2   2   2   2   2 NaN
     NaN NaN NaN   2   2   2   2   2   2   2   2   2 NaN NaN NaN NaN
     NaN NaN NaN NaN   2   2   2   2   2   2   2 NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN   2   2   2   2   2 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN   2   2   2 NaN NaN NaN NaN NaN NaN NaN
     NaN NaN NaN NaN NaN NaN NaN   2 NaN NaN NaN NaN NaN NaN NaN NaN
     ];
       hotspot = [9 8];          
       
       
    case 'zoomin'
       cdata = [...
     NaN NaN NaN NaN   1   1   1   1   1   1 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN   1   1   2   2   2   2   1   1 NaN NaN NaN NaN NaN
     NaN NaN   1   1   2   2   2   2   2   2   1   1 NaN NaN NaN NaN
     NaN   1   1   2   2   2   1   1   2   2   2   1   1 NaN NaN NaN
     NaN   1   2   2   2   2   1   1   2   2   2   2   1 NaN NaN NaN
     NaN   1   2   2   1   1   1   1   1   1   2   2   1 NaN NaN NaN
     NaN   1   2   2   1   1   1   1   1   1   2   2   1 NaN NaN NaN
     NaN   1   2   2   2   2   1   1   2   2   2   2   1 NaN NaN NaN
     NaN   1   1   2   2   2   1   1   2   2   2   1   1 NaN NaN NaN
     NaN NaN   1   1   2   2   2   2   2   2   2   1 NaN NaN NaN NaN
     NaN NaN NaN   1   1   2   2   2   2   1   1   2   1 NaN NaN NaN
     NaN NaN NaN NaN   1   1   1   1   1   1 NaN   1   2   1 NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1 NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   1   1
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     ];
         hotspot = [6 5];
         
    case 'zoomout'
       cdata = [...
     NaN NaN NaN NaN   1   1   1   1   1   1 NaN NaN NaN NaN NaN NaN
     NaN NaN NaN   1   1   2   2   2   2   1   1 NaN NaN NaN NaN NaN
     NaN NaN   1   1   2   2   2   2   2   2   1   1 NaN NaN NaN NaN
     NaN   1   1   2   2   2   2   2   2   2   2   1   1 NaN NaN NaN
     NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN NaN NaN
     NaN   1   2   2   1   1   1   1   1   1   2   2   1 NaN NaN NaN
     NaN   1   2   2   1   1   1   1   1   1   2   2   1 NaN NaN NaN
     NaN   1   2   2   2   2   2   2   2   2   2   2   1 NaN NaN NaN
     NaN   1   1   2   2   2   2   2   2   2   2   1   1 NaN NaN NaN
     NaN NaN   1   1   2   2   2   2   2   2   2   1 NaN NaN NaN NaN
     NaN NaN NaN   1   1   2   2   2   2   1   1   2   1 NaN NaN NaN
     NaN NaN NaN NaN   1   1   1   1   1   1 NaN   1   2   1 NaN NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1 NaN
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   1   2   1
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN   1   1
     NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN
     ];
         hotspot = [6 5]; 
         
   case 'matlabdoc'
       cdata = [...   
       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
       1   2   2   2   2   2   2   1   1   2   2   2   2   2   2   1
       1   2   2   2   2   2   2   1   1   2   2   2   2   2   2   1
       1   2   2   2   2   2   2   1   1   2   2   2   2   2   2   1
       1   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2   2   2   1
       1   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2   2   2   1
       1   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2   2   2   1
       1   1   1   1 NaN NaN NaN NaN NaN NaN NaN NaN   1   1   1   1
       1   1   1   1 NaN NaN NaN NaN NaN NaN NaN NaN   1   1   1   1
       1   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2   2   2   1
       1   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2   2   2   1
       1   2   2   2 NaN NaN NaN NaN NaN NaN NaN NaN   2   2   2   1
       1   2   2   2   2   2   2   1   1   2   2   2   2   2   2   1
       1   2   2   2   2   2   2   1   1   2   2   2   2   2   2   1
       1   2   2   2   2   2   2   1   1   2   2   2   2   2   2   1
       1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
       ];
         hotspot = [9 9]; 
         
    case 'none'
         
         cdata=repmat(nan,16,16);
         hotspot = [1 1]; 
       
    otherwise
       
       cdata=[];
       
end
   
if ~isempty(cdata)
   
    data={'Pointer','custom' , ...
      'PointerShapeCData',cdata, ...
      'PointerShapeHotSpot',hotspot};
     
else data={'Pointer',pointer_name};
     
end
 
set(fig,data{:})