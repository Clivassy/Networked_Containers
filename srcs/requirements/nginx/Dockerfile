FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache nginx
RUN apk add --no-cache nginx openssl

EXPOSE 443

COPY requirements/nginx/conf/nginx.conf /etc/nginx/http.d/nginx.conf
RUN chmod -R 755 /etc/nginx/http.d/nginx.conf

RUN mkdir -p /etc/nginx/ssl

# Create the key and the certifcate for TSL protocol
# -x509 refers to the certificate's type
# -out and -keyout parameters refers to where the certificate will be saved
# -subj refers to the command response (Country, STate, Locality, Organizati#on name, Organizational Unit name, Common Name (we can use our name))
RUN openssl req -x509 -nodes\
	-out /etc/nginx/ssl/ssl_certif.crt \
	-keyout /etc/nginx/ssl/ssl_key.key \
	-subj "/C=FR/ST=IDF/L=Paris/O=School/OU=42Paris/CN=jbatoro.42.fr"

RUN chmod -R 755 /var/www/
RUN chown -R nobody /var/www/

CMD ["nginx", "-g", "daemon off;"]
