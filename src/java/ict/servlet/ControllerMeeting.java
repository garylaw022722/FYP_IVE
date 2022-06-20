/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ict.servlet;

import ict.bean.meetingRequestBean;
import ict.db.MeetingDAO;
import ict.db.msql;
import java.io.IOException;
import java.sql.Time;
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
@WebServlet(name = "ControllerMeeting", urlPatterns = {"/ControllerMeeting"})
@MultipartConfig(maxFileSize = 16177215)
public class ControllerMeeting extends HttpServlet {

    public static final String lIST_STUDENT = "/Pagina11.jsp";
    public static final String INSERT_OR_EDIT = "/Pagina12.jsp";

    String estado = null;
    MeetingDAO imagendao;
    int id_pdf = -1;

    public ControllerMeeting() {
        imagendao = new MeetingDAO();
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
            meetingRequestBean imagenvo = imagendao.getImagenVOById(ordId);
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

        meetingRequestBean imagenvo = new meetingRequestBean();
        msql auto = new msql();
        int nuevoid = auto.auto_increm("SELECT MAX(reqNo) FROM meetingrequest;");

        try {
            String eAddress = request.getParameter("eAddress");
            imagenvo.seteAddress(eAddress);
            String approver = request.getParameter("approver");
            imagenvo.setApprover(approver);
            String status = request.getParameter("status");
            imagenvo.setStatus(status);
            String title = request.getParameter("title");
            imagenvo.setTitle(title);
            String comment = request.getParameter("comment");
            imagenvo.setComment(comment);
            String phoneCallTime = request.getParameter("phoneCallTime");
            imagenvo.setPhoneCallTime(phoneCallTime);
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
                imagenvo.setReqNo(nuevoid);
                imagendao.Agregar_ImagenVO(imagenvo);
            } else {
                imagenvo.setReqNo(id_pdf);
                imagendao.Modificar_ImagenVO(imagenvo);

            }
        } catch (Exception ex) {
            System.out.println("textos: " + ex.getMessage());
        }

        RequestDispatcher view = request.getRequestDispatcher("/Pagina11.jsp");
        view.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
