FROM node:20

COPY ./joyous_internship_front/joyous_internship_vue /joyous_internship_vue

RUN chown -R www-data:www-data joyous_internship_vue

# Set working directory
WORKDIR /joyous_internship_vue

RUN npm install

#Expose port 5173
EXPOSE 5173