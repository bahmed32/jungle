describe("Product", () => {

  beforeEach(() => {
    cy.visit('/') 
    cy.get(".products article")
      .should("be.visible")
      .should("have.length", 2);
  })

  it ('finds product 1 and shows all feature details', () => {
    cy.contains('Giant Tea')
      .click() 
      .location('pathname').should('eq', '/products/1')
      .get(".products-show .product-detail")
      .should("be.visible")
      .contains('Giant Tea');
  });

  it ('finds product 2 and shows all feature details', () => {
    cy.contains('Scented Blade')
      .click() 
      .location('pathname').should('eq', '/products/2')
      .get(".products-show .product-detail")
      .should("be.visible")
      .contains('Scented Blade');
  });


});