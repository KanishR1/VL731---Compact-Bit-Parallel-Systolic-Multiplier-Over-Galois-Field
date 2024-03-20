def generate_gf2m_polynomials(m):
    """
    Generate all polynomials of degree less than or equal to m over GF(2^m).
    
    Args:
    m (int): The degree of the polynomials.
    
    Returns:
    list of str: A list of strings representing each polynomial.
    """
    polynomials = []
    for i in range(2**(m+1)):
        # Convert integer to binary, remove the '0b' prefix, and pad with zeros
        binary_repr = format(i, '0' + str(m+1) + 'b')
        # Convert binary representation to polynomial form
        poly = ''
        for power, coeff in enumerate(reversed(binary_repr)):
            if coeff == '1':
                if power == 0:
                    poly += '1 + '
                elif power == 1:
                    poly += 'x + '
                else:
                    poly += 'x^{} + '.format(power)
        # Remove trailing " + " if the polynomial is not empty
        poly = poly.rstrip(' + ')
        # Handle the case of the zero polynomial
        if not poly:
            poly = '0'
        polynomials.append(poly)
    return polynomials

# Example: Generate all polynomials in GF(2^3)
m = 4
polys = generate_gf2m_polynomials(m)
for poly in polys:
    print(poly)

