from sympy import symbols, poly, GF

# Define the symbol
x = symbols('x')

def generate_irreducible_polynomials(m):
    """
    Generate all irreducible polynomials of degree m over GF(2).
    """
    irreducibles = []
    # Generate all polynomials of degree m and check for irreducibility
    for i in range(1 << m, 1 << (m + 1)):
        coeffs = [int(bit) for bit in bin(i)[2:]]
        p = poly(sum(coeff * x**j for j, coeff in enumerate(reversed(coeffs))), domain=GF(2))
        if p.is_irreducible:
            irreducibles.append(p)
    return irreducibles

# Example: Generate all irreducible polynomials of degree 3 over GF(2)
m = 7
irreducible_polys = generate_irreducible_polynomials(m)
for poly in irreducible_polys:
    print(poly)

