using Plots
function NewtonMethod(f::Function, fPrime::Function, x1::Float64, n::Int64, tol)
    # Create an empty array for storing the roots
    roots = []
    # Iterate n times over the formula to obtain a suitable approximation of the root
    for i in 1:n 
        x_new = x1 - (f(x1))/fPrime(x1)
        # Check if the y value at the current x point is close to 0
        if abs(f(x_new)) < tol 
            break
        end
        # Update x1 to be the new approximation value
        x1 = x_new
        push!(roots, x1)
        print("Root at ", i, " iteration is ", x1, "\n")
    end
    # If there is no suitable root found under this approximation, return the array.
    return roots
end
 # Testing an example
f(x) = x^3 - x - 2
fPrime(x) = 3*x^2 -1

elapsed_time = @elapsed begin
    roots = NewtonMethod(f, fPrime, 2.5, 10, 1e-15)
end
print("The time needed to find the root: ", roots[end], " is ", elapsed_time, " seconds.")

# Calculating errors for the Newton NewtonMethod
true_root = 1.5213797068045678
errors = abs.(roots.-true_root)


# Plotting the errors with iteration numbers
iterations = 1:length(errors)  # Create a vector of iteration numbers
plot(iterations, errors, marker=:o, line=:auto, title="Errors in Newton Method\n Function: f(x) = x^3 - x - 2", xlabel="Iteration Number", ylabel="Absolute Error", legend=false)
savefig("NewtonMethodError.png")