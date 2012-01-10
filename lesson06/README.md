This exercise demonstrates how to implement a simple web service with Apache Httpd and CGI.  I assume you are working on Ubuntu, but any Unix system will do.

## Exercise: see this working

Install this program in Apache.  

Add the following line to /etc/hosts
 
    127.0.0.1 todo-list
  
Add the following file to /etc/apache2/sites-available.  Call it `todo-list`.  Substitute /home/matteo with your home folder.  You may use another directory, as long as it is *not* under the general Apache DocumentRoot (which is usually /var/www).

    <VirtualHost *:80> 
      ServerName todo-list 
      ErrorLog     /home/matteo/work/todo-list/log/error_log
      CustomLog    /home/matteo/work/todo-list/log/access_log common
      DocumentRoot /home/matteo/work/todo-list/public 
      <Directory /home/matteo/work/todo-list/public> 
        AllowOverride All 
        Order allow,deny 
        Allow from all 
      </Directory> 
    </VirtualHost>
    
Enable the new virtual host:

    $ sudo a2ensite todo-list
    
Restart Apache

    $ sudo apache2ctl restart

Grant write access to the `log` directory to the www user.  Or more simply, to anyone

    $ chmod 777 /home/matteo/work/todo-list/log
    
If you did everything correctly, you should be able direct your browser to `http://todo-list/` and see the "Hello from Ruby" message.  You should also be able to see the static files in the `public` directory, such as `http://todo-list/css/style.css` and see our stylesheet. 

You should also check that every url that does not belong to a static file will be redirected to the route.cgi script; for instance `http://todo-list/pippo` should also show "Hello from Ruby".

If anything breaks, you should check both the Apache error log `/var/log/apache2/error_log` and your application's error log `/home/matteo/work/todo-list/log/error_log`

