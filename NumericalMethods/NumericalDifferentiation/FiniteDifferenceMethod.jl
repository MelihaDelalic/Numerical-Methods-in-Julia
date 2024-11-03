using Plots
function ForwardDifferenceMethod(f::Function, a::Float64, b::Float64,  h::Float64)
   # Create an array for storing the derivatives
   derivatives = []
   # Iterate over the formula n-1 times until it calculates derivatives at each point
   x_current = a
   while x_current + h <= b
        x_next = x_current + h
        fPrime = (f(x_next)-f(x_current))/h
        push!(derivatives, fPrime)  # Store the derivative
        x_current += h  # Move to the next point
   end
    return derivatives
end

function BackwardDifferenceMethod(f::Function, a::Float64, b::Float64, h::Float64)
    # Create an array for storing the derivative at each iteration
    derivatives = []
    # Use while loop to calculate the derivatives
    x_current = b
    while x_current >= a 
        x_back = x_current - h  
        result = (f(x_current)-f(x_back))/h
        # Store the values
        push!(derivatives, result)
        # Update the x_current 
        x_current = x_current - h
    end 
    return reverse(derivatives)
end

function CentralDifferenceMethod(f::Function, a::Float64, b::Float64, h::Float64) 
     # Create an array for storing the derivative at each iteration
     derivatives = []
     x_current = a
     while x_current <= b 
        # Update the new values of x_next and x_prev
        x_next = x_current + h 
        x_prev = x_current - h
        result = (f(x_next)-f(x_prev))/(2*h)
        push!(derivatives, result) 
        x_current += h
     end
     return derivatives
end


# example 
f(x) = x^2
derivative_forward = ForwardDifferenceMethod(f, 1.1, 1.4, 0.05)
derivative_back = BackwardDifferenceMethod(f, 1.1, 1.4, 0.05)
derivative_central = CentralDifferenceMethod(f, 1.1, 1.4, 0.05)
# Calculate the error:
true_derivative(x) = 2*x # Analytical result
length(derivative_central)
# Error in Forward Difference Method
error1 = abs((derivative_forward[end]-exact_derivative)/exact_derivative)*100
print("The absolute error of forward method is $error1 percent with h=0.05.")
# Error in Backward Difference Method
error2 = abs((derivative_back[end]-exact_derivative)/exact_derivative)*100
print("The absolute error of backward method is $error2 percent with h=0.05.")
error3 = abs((derivative_central[end]-exact_derivative)/exact_derivative)
print("The absolute error of central method is $error3 percent with h=0.05.")

# Visualize the three methods by plotting the three approximations along with the exact derivative.

x_values = 1.1:0.05:1.3
y = true_derivative.(x_values)
plot(x_values, y, label = "Exact derivative", ylabel = "Exact derivatives", lw=2, linestyle=:dash, color=:black )
plot!(x_values, derivative_forward, label = "Forward Method", linestyle=:solid, lw=2, color=:blue)

# Adapt the x values for the backward and central method
x_back = x_values[1:3] # Since in the backward method the array is 3-element, here we only take the three elements of x_values for plotting
x_central = x_values[1:4]  # Same is done for central method array of 4 elements

plot!(x_values[1:3], derivative_back, label = "Backward Method", linestyle=:solid, lw=2, color=:red)
plot!(x_values[1:4], derivative_central, label = "Central Method", linestyle=:solid, lw=2, color=:green)
savefig("FiniteDifferenceMethods.png")
# Also plot the function for which we found derivative, in this case y = x^2
# funct = f.(x_values)
# plot!(x_values, funct, label = "Function f(x)= x^2", lw=1, linestyle=:solid, color=:black)