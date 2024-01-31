describe("Cart", () => {

  it('on homepage a profuct is added to the cart and the cart total now equals 1', () => {
    cy.visit('/');
    cy.get('nav')
    .contains('My Cart (0)');

    cy.get('button')
      .contains('Add')
      .click({ force: true });

      cy.get('nav')
      .contains('My Cart (1)');
  });

  it('on product page a profuct is added to the cart and the cart total now equals 1' , () => {
    cy.visit("/products/1");

    cy.get('nav')
    .contains('My Cart (0)');

    cy.get('button')
      .contains('Add')
      .click({ force: true });
      cy.get('nav')
      .contains('My Cart (1)');

      cy.visit("/products/2");

      cy.get('nav')
      .contains('My Cart (1)');

      cy.get('button')
      .contains('Add')
      .click({ force: true });

      cy.get('nav')
      .contains('My Cart (2)');
  });

});