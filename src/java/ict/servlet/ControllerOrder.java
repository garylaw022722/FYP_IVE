/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.OrderBean;
import ict.db.orderDAO;
import ict.db.psql;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author user
 */
@WebServlet(name = "ControllerOrder", urlPatterns = {"/ControllerOrder"})
@MultipartConfig(maxFileSize = 16177215)
public class ControllerOrder extends HttpServlet {

    public static final String lIST_STUDENT = "/Pagina1.jsp";
    public static final String INSERT_OR_EDIT = "/Pagina2.jsp";

    String estado = null;
    orderDAO imagendao;
    int id_pdf = -1;

    public ControllerOrder() {
        imagendao = new orderDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String forward = "";
        String action = request.getParameter("action");

        if (action.equalsIgnoreCase("delete")) {
            forward = lIST_STUDENT;
            int ordId = Integer.parseInt(request.getParameter("id"));
            imagendao.Eliminar_ImagenVO(ordId);
        }
        if (action.equalsIgnoreCase("edit")) {
            forward = INSERT_OR_EDIT;
            int ordId = Integer.parseInt(request.getParameter("id"));
            id_pdf = ordId;
            OrderBean imagenvo = imagendao.getImagenVOById(ordId);
            request.setAttribute("row", imagenvo);
            boolean boo = true;
            request.setAttribute("row2", boo);
            estado = "edit";
        } else if (action.equalsIgnoreCase("insert")) {
            forward = INSERT_OR_EDIT;
            estado = "insert";
        }

        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderBean imagenvo = new OrderBean();
        psql auto = new psql();
        int nuevoid = auto.auto_increm("SELECT MAX(ord_id) FROM orderrequest;");

        try {
            String eAddress = request.getParameter("eAddress");
            imagenvo.seteAddress(eAddress);
            String pid = request.getParameter("pid");
            imagenvo.setPid(pid);
            double ordDiscount = Double.parseDouble(request.getParameter("ordDiscount"));
            imagenvo.setOrdDiscount(ordDiscount);
            String status = request.getParameter("status");
            imagenvo.setStatus(status);
            String approver = request.getParameter("approver");
            imagenvo.setApprover(approver);
            int amount = Integer.parseInt(request.getParameter("amount"));
            imagenvo.setAmount(amount);
            int storeId = Integer.parseInt(request.getParameter("storeId"));
            imagenvo.setStoreId(storeId);
        } catch (Exception ex) {
            System.out.println("nombre: " + ex.getMessage());
        }


        try {
            Part filePart = request.getPart("fichero");
            if (filePart.getSize() > 0) {
                System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());

            }
        } catch (Exception ex) {
            System.out.println("fichero: " + ex.getMessage());
        }

        try {

            if (estado.equalsIgnoreCase("insert")) {
                imagenvo.setOrdId(nuevoid);
                imagendao.Agregar_ImagenVO(imagenvo);
            } else {
                imagenvo.setOrdId(id_pdf);
                imagendao.Modificar_ImagenVO(imagenvo);

            }
        } catch (Exception ex) {
            System.out.println("textos: " + ex.getMessage());
        }

        RequestDispatcher view = request.getRequestDispatcher("/Pagina1.jsp");
        view.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
