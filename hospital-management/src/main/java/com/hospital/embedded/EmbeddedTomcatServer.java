package com.hospital.embedded;

import java.io.File;

import org.apache.catalina.Context;
import org.apache.catalina.startup.Tomcat;

public class EmbeddedTomcatServer {

    public static void main(String[] args) throws Exception {
        String warPath = "target/hospital-management.war";
        int port = 8080;

        for (int i = 0; i < args.length; i++) {
            if ("--war".equals(args[i]) && i + 1 < args.length) {
                warPath = args[++i];
            } else if ("--port".equals(args[i]) && i + 1 < args.length) {
                port = Integer.parseInt(args[++i]);
            }
        }

        File warFile = new File(warPath);
        if (!warFile.exists()) {
            System.err.println("WAR file not found: " + warFile.getAbsolutePath());
            System.exit(1);
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.getConnector();

        Context ctx = tomcat.addWebapp("/hospital-management", warFile.getAbsolutePath());
        ctx.setParentClassLoader(EmbeddedTomcatServer.class.getClassLoader());

        System.out.println("Starting embedded Tomcat on http://localhost:" + port + "/hospital-management/");
        tomcat.start();
        tomcat.getServer().await();
    }
}
