package entities;

import entities.OrderItem;
import entities.User;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-05-12T15:11:25")
@StaticMetamodel(Order.class)
public class Order_ { 

    public static volatile SingularAttribute<Order, Double> total;
    public static volatile SingularAttribute<Order, Long> id;
    public static volatile SingularAttribute<Order, Date> orderDate;
    public static volatile SingularAttribute<Order, User> user;
    public static volatile ListAttribute<Order, OrderItem> items;
    public static volatile SingularAttribute<Order, String> status;

}