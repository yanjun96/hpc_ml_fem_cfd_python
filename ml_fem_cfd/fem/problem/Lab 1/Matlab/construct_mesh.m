function Th = mesh(xL, xR, N)
    % Construct a mesh Th for a one-dimensional domain [xL, xR] with N+1 points.

    % Calculate the size of each element
    dx = (xR - xL) / N;

    % Initialize an empty cell array to store the mesh elements
    Th = cell(1, N);

    % Generate the mesh elements
    for i = 1:N
        xi = xL + (i - 1) * dx;
        xi_plus_1 = xi + dx;
        Th{i} = [xi, xi_plus_1];
    end
end

% Example usage:
xL = 0.0;
xR = 1.0;
N = 5;
mesh = construct_mesh(xL, xR, N);
disp(mesh);