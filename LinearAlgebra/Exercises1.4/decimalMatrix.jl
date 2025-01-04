using Printf

function ScalarMultiplication(matrix::Matrix, c::Int64)
    rows, cols = size(matrix)
    result = zeros(eltype(matrix), rows, cols)
     for i in 1:rows 
         for j in 1:cols 
             result[i,j] = c * matrix[i,j]
         end
     end
     return result
 end
 # A = [0.1 0.01; 0.001 0.0001]
 
 A = [1 2; -3 2]
 B = [1 -1; 2 3]
 ScalarMultiplication(A, 3)
 precision = typemax(Int)

 function MatrixRaisedtoPower(A::Matrix, p::Int64)
    rowsA, colsA = size(A)
    if rowsA != colsA
        error("Matrix must be square.")
    end
    result = copy(A)
    C = zeros(eltype(A), rowsA, colsA)
    for k in 2:p
        for i in 1:rowsA
            for j in 1:colsA 
                for l in 1:rowsA
                C[i,j] += result[i,l]*A[l,j]
                end
            end
        end
        result = C
    end
    return result
end