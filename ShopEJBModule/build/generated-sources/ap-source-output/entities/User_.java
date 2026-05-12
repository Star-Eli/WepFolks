package entities;

import entities.Order;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2026-05-12T15:11:25")
@StaticMetamodel(User.class)
public class User_ { 

    public static volatile SingularAttribute<User, byte[]> image;
    public static volatile SingularAttribute<User, String> role;
    public static volatile SingularAttribute<User, String> address;
    public static volatile SingularAttribute<User, String> city;
    public static volatile SingularAttribute<User, Double> creditUsed;
    public static volatile SingularAttribute<User, String> creditStatus;
    public static volatile SingularAttribute<User, String> employmentStatus;
    public static volatile SingularAttribute<User, String> password;
    public static volatile SingularAttribute<User, String> province;
    public static volatile SingularAttribute<User, String> phone;
    public static volatile SingularAttribute<User, String> name;
    public static volatile SingularAttribute<User, Double> creditLimit;
    public static volatile ListAttribute<User, Order> orders;
    public static volatile SingularAttribute<User, Long> id;
    public static volatile SingularAttribute<User, String> email;
    public static volatile SingularAttribute<User, String> monthlyIncome;

}