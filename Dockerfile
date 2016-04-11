FROM rails:4.2.5

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

COPY Gemfile Gemfile.lock /usr/src/app/

WORKDIR /usr/src/app/

RUN bundle install

COPY . /usr/src/app

EXPOSE 80

CMD rake db:migrate && rake db:seed && rails server -b 0.0.0.0 -p 80