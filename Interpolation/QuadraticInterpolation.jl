using Plots
function Gauss_Jordan(A::Matrix, b::Vector)
    A = copy(A)
    b = copy(b)
    rows, cols = size(A)
    lenb = length(b)
    
    if rows != lenb 
        println("Sizes do not match. Impossible to write the augmented matrix.")
        return
    end

    for k in 1:rows
        # Ensure the pivot is not zero, if zero find a row to swap
        if A[k, k] == 0
            swap_row = findfirst(x -> x != 0, A[k+1:end, k])
            if swap_row === nothing
                println("Matrix is singular, cannot proceed with Gauss-Jordan elimination.")
                return
            else
                swap_row += k # adjust index because of slicing
                A[k, :], A[swap_row, :] = A[swap_row, :], A[k, :]
                b[k], b[swap_row] = b[swap_row], b[k]
            end
        end

        # Normalize the pivot row
        pivot = A[k, k]
        A[k, :] /= pivot
        b[k] /= pivot
        
        # Eliminate all other entries in the current column
        for i in 1:rows
            if i != k
                factor = A[i, k]
                A[i, :] -= factor * A[k, :]
                b[i] -= factor * b[k]
            end
        end
    end

    return A, b
end

function QuadraticInterpolation(X::Vector, Y::Vector)
    lenx = length(X)
    leny = length(Y)
    if lenx != 3 || leny != 3
        println("Fix the vector lengths.")
    end
    row1 = [(X[1])^2, X[1], 1]
    row2 = [(X[2])^2, X[2], 1]
    row3 = [(X[3])^2, X[3], 1]
    A = vcat(row1', row2', row3')
    A, coefficients = Gauss_Jordan(A, Y)   
    return coefficients

end
# X = Float16[-1, 3, 0]
# Y = Float16[2, 14,-1]
 X = Float64[0,1,4]
 Y = Float64[0,1,2]
coef = QuadraticInterpolation(X,Y)
g(x) = coef[1]*(x^2) + coef[2]*x + coef[3]
point1 = g(2.0)
# x = -4:1:4
x = -1:1:5
plot(x, g, title = "Interpolation of the polynomial", xlabel="x", ylabel="g(x)")
scatter!(X, Y, label="Data Points", color=:red, marker=:circle, markersize=5)
scatter!(2.0, point1)