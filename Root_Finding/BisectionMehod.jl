using Plots

function BisectionMethod(a::Int64, b::Int64, f::Function, n::Int64, tol)
    # Create empty array for storing the roots and iterations 
    roots = []                                                
    iterations = []
    # Check if the boundaries bracket the root
    f_a, f_b = f(a), f(b)
    if sign(f_a)==sign(f_b)
        error("The values f(a) and f(b) should have opposite signs")
    end

    #iterate over the process n times
    for i in 1:n

        #calculate the next x value
        root = b - (b-a)/2 
        #check if we found the root
        if abs(f(root)) < tol
            break 
        end
        #update the interval 
        if sign(f(a))*sign(f(root))<0 
            b = root 
        else a = root
        end
       
        # Store values in the root array at each iteration
        push!(roots, root)
        push!(iterations, i)
        print("The root at ", i, " iteration is ", root, ".\n")
    end
    return roots, iterations
end  

# test 
f(x) = x^3 - x - 2
g(x) = cos(x)-x
h(x) = exp(x)-4*x
i(x) = x^5 - 100*x +1

# Testing
time_elapsed = @time begin
    roots, iterations = BisectionMethod(0, 2, f, 1000, 1e-15)
end
print("Root of the function is ", roots[end], " and the time needed for the function to converge is ", time_elapsed, " seconds ",
"in ", iterations[end], " iterations.")


# Plotting the curve and the root
x = -2:0.1:2
y = f.(x)
plot(x, y, xlabel = "x-axis", ylabel = "y-axis", label = "Function f(x) = x^3 - x - 2", linestyle=:solid, color=:green, lw=2)
scatter!([roots], [f(roots)], color=:red, marker=:circle, label="Root")

# Calculating the errors 

true_root = 1.5213797068045678
errors = abs.(roots.-true_root)

# Plotting the error curve

iterations = 1:length(errors)
plot(iterations, errors, marker=:o, line=:auto, title = "Errors in Bisection Method\nFunction: f(x) = x^3 - x - 2", xlabel = "iterations", ylabel = "errors", legend=false)
savefig("BisectionMethodErrors.png")