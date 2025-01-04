function SecantMethod(f::Function, xk::Float64, xPrev::Float64, n::Int64, tol::Float64)
    # Create arrays for storing the roots and iterations
    roots = []
    iterations = []
    # Iterate over the main command n times until the value of the function at that point is close to 0
    for i in 1:n 
        x_new = xk - (f(xk)*(xk-xPrev))/(f(xk)-f(xPrev))
        # Check if the function at current iteration x has a value close to 0
        if abs(f(x_new))<tol
            break 
        end
        print("Root at ", i, " iteration is ", xk, "\n")
        push!(roots, xk)
        push!(iterations, i)
        # Reassign xk to the next value of x_new
        xk = x_new 
    end
    return roots, iterations
end

f(x) = x^3 - x - 2
time_elapsed = @elapsed begin
    roots, iterations = SecantMethod(f, 3.0, 2.0, 10, 1e-15)
end
print("Root of the function is ", roots[end], " and the time needed for the function to converge is ", time_elapsed, " seconds ",
"in ", iterations[end], " iterations.")
