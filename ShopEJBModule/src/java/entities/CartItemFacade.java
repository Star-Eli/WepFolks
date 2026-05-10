/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Vutomi Nyarhi
 */
@Stateless
public class CartItemFacade extends AbstractFacade<CartItem> implements CartItemFacadeLocal {

    @PersistenceContext(unitName = "ShopEJBModulePU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CartItemFacade() {
        super(CartItem.class);
    }
    
}
