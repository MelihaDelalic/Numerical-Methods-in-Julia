function MultiplyMatrices(A::Matrix, B::Matrix)
    rowsA, colsA = size(A)
    rowsB, colsB = size(B)
    
    if colsA == rowsB
    result = zeros(Int64, rowsA, colsB)
    
    for i in 1:rowsA
        for j in 1:colsB
            for k in 1:colsA
                result[i, j] += A[i, k] * B[k, j]
            end
        end
    end
else println("Size do not match")
end
    return result
end
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

A = [1 2; -3 2]
B = [1 -1; 2 3]

AB = MultiplyMatrices(A,B)
ABsquared = MatrixRaisedtoPower(AB, 2)