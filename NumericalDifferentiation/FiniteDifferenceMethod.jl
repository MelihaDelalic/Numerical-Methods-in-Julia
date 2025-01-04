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
