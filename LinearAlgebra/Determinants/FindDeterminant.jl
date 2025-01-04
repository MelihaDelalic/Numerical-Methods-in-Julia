function Determinant(A::Matrix)
    B = copy(A)
    # check if the determinant is square
    rows, cols = size(B)
    if rows != cols
        println("ERROR. The matrix is not square.")
    end
    # zero out below diagonal entries
    for i in 1:rows
        pivot = B[i,i]
        if pivot == 0
            println("Error. The matrix is singular.")
            return 0
        end
        for j in i+1:rows
            factor = B[j,i]/pivot
            for k in i:cols
                B[j,k] = B[j,k] - factor*B[i,k]
            end
        end
    end
    # calculate the determinant as the product of diagonal elements
    det = 1.0
    for i in 1:rows
       det = det*B[i,i]
    end
    return det
end

A = Float64[2 1 0 0; 1 2 1 0; 0 1 2 1;0 0 1 2]
Determinant(A)