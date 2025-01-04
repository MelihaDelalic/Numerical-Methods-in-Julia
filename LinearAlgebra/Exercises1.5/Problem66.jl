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

# A = [0 1 0 0 0; 0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1; 0 0 0 0 0]
# A = [1/2 1/3;1/4 1/5]
A = [1 -1 0; 0 1 -1; -1 0 1]
MatrixRaisedtoPower(A, 3)
MatrixRaisedtoPower(A, 66)