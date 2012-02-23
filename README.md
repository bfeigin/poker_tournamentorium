# Automated Poker Tournament System

## Installation
<pre>
git clone git://github.com/bfeigin/poker_tournamentorium.git
bundle install
bundle exec padrino rake ar:schema:load
bundle exec padrino start

# To test
bundle exec padrino rake ar:schema:load -e test
bundle exec padrino rake spec
bundle exec cucumber
</pre>



