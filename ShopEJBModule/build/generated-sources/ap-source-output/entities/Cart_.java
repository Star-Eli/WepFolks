package entities;

import entities.CartItem;
import entities.User;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-05-12T15:11:25")
@StaticMetamodel(Cart.class)
public class Cart_ { 

    public static volatile SingularAttribute<Cart, Long> id;
    public static volatile SingularAttribute<Cart, User> user;
    public static volatile ListAttribute<Cart, CartItem> items;

}