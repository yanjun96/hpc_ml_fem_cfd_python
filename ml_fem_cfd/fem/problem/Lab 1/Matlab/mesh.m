function Th = mesh(x_min, x_max, N)
       
    dx = (x_max - x_min) / N; 
    % Construct a mesh Th for a one-dimensional domain [xL, xR] with N+1 points.
    % Calculate the size of each element
    % Generate the mesh elements
    for i = 1:N+1
        xi = x_min + (i-1) * dx;
        Th(i) = xi;     
    end
end

