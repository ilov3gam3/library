package Init;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

public class ServerStartListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        Config.contextPath = context.getContextPath();
        Config.vnp_ReturnUrl = Config.app_url + Config.contextPath + "/user/vnpay-result";
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
