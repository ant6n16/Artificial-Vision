function W=creaObjeto(x,y,tamx, tamy,z)

% MADE BY ANTONIO DELGADO BEJARANO.

% Function that creates an array of coordinates of points of an object
% traversing it from left to right and from bottom to top.
% Input Variables:
% x: Number of columns of points that define it.
% y: Number of rows of points that define it.
% tamx, tamy: Distance in mm between the points in x and y, respectively.
%z: z coordinate of the flat object.

%%%%%%%%%%%%%%%%%%%% Object definition: %%%%%%%%%%%%%%%%%%%%

if nargin < 5   % If no z coordinate is given, it is assigned as 0.
    z=0;
end

% Definition of the object's coordinate matrix:
W=[ones(2,x*y); z*ones(1,x*y)];

j=1;   % First index of the array.

for i=0:y-1
    for k=0:x-1
        
        % The x and y coordinates are assigned in meters:
        W(1,k+j)=tamx*k/1000;
        W(2,k+j)=tamy*i/1000;
        
    end
    
    j=j+x; % Skips to the next row of the object.
    
end

end
