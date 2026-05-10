/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author Vutomi Nyarhi
 */
@Entity
@Table(name = "users")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
    private String name;

    @Column(unique = true, nullable = false)
    private String email;

    private String password;

    private String role; // CUSTOMER, ADMIN
    
    private String address;
    private String city;
    private String province;
    private String phone;
    
    // CREDIT FIELDS - Buy Now Pay Later Feature
    private double creditLimit;      // Total credit approved
    private double creditUsed;       // Credit used so far
    private double creditAvailable;  // Available credit
    private String creditStatus;     // NONE, PENDING, APPROVED, REJECTED, ACTIVE
    private String monthlyIncome;    // Monthly income range
    private String employmentStatus; // EMPLOYED, SELF_EMPLOYED, STUDENT

    @OneToMany(mappedBy = "user")
    private List<Order> orders;
    
    @Lob
    private byte[] image;

    public User() {
        // Initialize credit fields with default values
        this.creditLimit = 0;
        this.creditUsed = 0;
        this.creditAvailable = 0;
        this.creditStatus = "NONE";
    }

    public User(String name, String email, String password, String role, List<Order> orders) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.orders = orders;
        this.creditLimit = 0;
        this.creditUsed = 0;
        this.creditAvailable = 0;
        this.creditStatus = "NONE";
    }

    // Phone Getters and Setters
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    // Credit Fields Getters and Setters
    public double getCreditLimit() {
        return creditLimit;
    }

    public void setCreditLimit(double creditLimit) {
        this.creditLimit = creditLimit;
    }

    public double getCreditUsed() {
        return creditUsed;
    }

    public void setCreditUsed(double creditUsed) {
        this.creditUsed = creditUsed;
    }

    public double getCreditAvailable() {
        return creditAvailable;
    }

    public void setCreditAvailable(double creditAvailable) {
        this.creditAvailable = creditAvailable;
    }

    public String getCreditStatus() {
        return creditStatus;
    }

    public void setCreditStatus(String creditStatus) {
        this.creditStatus = creditStatus;
    }

    public String getMonthlyIncome() {
        return monthlyIncome;
    }

    public void setMonthlyIncome(String monthlyIncome) {
        this.monthlyIncome = monthlyIncome;
    }

    public String getEmploymentStatus() {
        return employmentStatus;
    }

    public void setEmploymentStatus(String employmentStatus) {
        this.employmentStatus = employmentStatus;
    }

    // Original Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof User)) {
            return false;
        }
        User other = (User) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.User[ id=" + id + " ]";
    }
    
}