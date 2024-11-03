
function GetInverse(A::Matrix)
    # check if the matrice is square
    rows, cols = size(A)
    if rows != cols
        println("The matrix is not square.")
    end
    # create an identity matrix
    I = zeros(eltype(A), rows, cols)
    for i in 1:rows
        for j in 1:cols
            if i==j
                I[i,j] = 1
            end
        end
    end
    # perform row operations on both A and I 
    for i in 1:rows

        if A[i,i] == 0
            swap_row = findfirst(x -> x != 0, A[i+1:end, i])
            if swap_row === nothing
            println("Matrix is singular, cannot proceed with Gauss-Jordan elimination.")
            return
            else
            swap_row += i # adjust index because of slicing
                A[i, :], A[swap_row, :] = A[swap_row, :], A[i, :]
                I[i, :], I[swap_row] = I[swap_row], I[i, :]
            end
        end
     # Normalize the pivot row
     pivot = A[i, i]
     A[i, :] /= pivot
     I[i, :] /= pivot

     # Eliminate all other entries in the current column
     for j in 1:rows

        if j != i
        factor = A[j, i]
        A[j, :] -= factor * A[i, :]
        I[j, :] -= factor * I[i, :]
        end
    
     end
   
   end
   
   return A, I

end
A = Float64[1 3; 2 4]
A = Float64[4 0 0; 0 -3 0; 0 0 2]
inverse = GetInverse(A)
println(inverse)