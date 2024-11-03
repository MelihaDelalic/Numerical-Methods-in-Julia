using Plots
function PiecewiseInterpolation(X::Array{Float64}, Y::Array{Float64}, Xq::Array{Float64})
    Yq = []  # Create an array for the query y values
    n = length(X)
    for xq in Xq  # Loop through each query point in Xq
        found = false  # Flag to check if an interval was found
        for i in 1:n-1 
        y=0
            if xq >= X[i] && xq <= X[i+1]
            y = ((Y[i+1]-Y[i])/(X[i+1]-X[i]))*(Xq[i]-X[i]) + Y[i]
            push!(Yq, y)
            found = true  # Mark that we've found an interval
            break # Exit the loop after fidning the correct interval
            end
        end
        if !found  # If no interval was found
            push!(Yq, NaN)  # Push NaN or handle as needed
        end
    end
    return Yq
end

# Example 1 - Weather throughout the day 
X = Float64[8, 12, 16, 20] # hours throughout the day 
Y = Float64[20, 24, 22, 18] # temperatures in Celsiuz at the specific times 
Xq = Float64[9, 10, 11, 13, 14, 15, 16, 17, 19, 20] # the hours of the day at which I wish to find the temperatures 
Yq = PiecewiseInterpolation(X, Y, Xq)
print(Yq)
# Plot the results
plot(X, Y, seriestype = :scatter, label = "Original Data", marker = (:circle, 5), color =:black)
plot!(Xq, Yq, label = "Interpolated Data", marker = (:cross, 6), color = :red)
# Adding labels and title
xlabel!("Time (Hours)")
ylabel!("Temperature (°C)")
title!("Temperature Interpolation Throughout the Day")
# Annotate the Xq and Yq points
for (i, xq) in enumerate(Xq)
    annotate!(xq, Yq[i], text("($xq, $(Yq[i]))", 10, :black))  # Annotate each query point
end
# Display the plot
display(plot!)

# Example 2 - Estimating fuel consumption 
X = Float64[20, 40, 60, 80, 100]  # Speed in km/h
Y = Float64[0.08, 0.06, 0.05, 0.07, 0.09]  # Fuel consumption in liter/km 
# Estimate the fuel consumption at the speeds:
Xq = Float64[23, 35, 50, 65, 75, 90] # km/h 
Yq = PiecewiseInterpolation(X, Y, Xq)
# Plot the results 
plot(X, Y, label = "Original Data", seriestype=:scatter, color=:blue, marker=(:circle, 4))
plot!(Xq, Yq, label =" Interpolated Data", seriestype=:scatter, color=:red, marker=(:circle, 4))
xlabel!("Speed in (km/h")
ylabel!("Fuel Consumption in (liter/km) - Piecewise Interpolation")
savefig("Fuel Consumption Estimation - Piecewise Interpolation.png")