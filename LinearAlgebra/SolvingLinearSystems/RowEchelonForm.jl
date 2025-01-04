function SwitchRows(A::Matrix, row1::Int64, row2::Int64)
rows, cols = size(A)
if row1>rows || row2>rows
    println("The row index exceeds the size of the matrix.")
end
temp = A[row1, :]
A[row1, :] = A[row2, :]
A[row2, :] = temp
return A
end
A = [1 0 0; 0 1 0; 0 0 1]
A = [1 2 3;4 5 6; 7 8 9]
SwitchRows(A, 1, 3)

function Gauss_Jordan(A::Matrix, b::Vector)
    A = copy(A)
    b = copy(b)
    rows, cols = size(A)
    lenb = length(b)
    
    #=if rows != lenb 
        println("Sizes do not match. Impossible to write the augmented matrix.")
        return
    end=#

    for k in 1:rows
        # Ensure the pivot is not zero, if zero find a row to swap
        if A[k, k] == 0
            swap_row = findfirst(x -> x != 0, A[k+1:end, k])
            if swap_row === nothing
                println("Matrix is singular, cannot proceed with Gauss-Jordan elimination.")
                println("")
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

A = Float16[1 1 4 1 2; 0 1 2 1 1; 0 0 0 1 2; 1 -1 0 0 2; 2 1 6 0 1]
b = Float16[0,0,0,0,0]
result = Gauss_Jordan(A,b)
println(result)