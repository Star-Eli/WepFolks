/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author Vutomi Nyarhi
 */
@Local
public interface CartItemFacadeLocal {

    void create(CartItem cartItem);

    void edit(CartItem cartItem);

    void remove(CartItem cartItem);

    CartItem find(Object id);

    List<CartItem> findAll();

    List<CartItem> findRange(int[] range);

    int count();
    
}
