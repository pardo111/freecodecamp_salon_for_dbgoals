#! /bin/bash
PSQL="psql -X --username=postgres --dbname=salon  --no-align --tuples-only -c"
num(){
    echo -e "What's your phone number?"
    read CUSTOMER_PHONE
}

lectura() {
    echo -e "\n\n~~~~~ MY SALON ~~~~~\n\n"
    
    echo -e "\n\nWelcome to My Salon, how can I help you?\n\n"
    echo -e "\n
1) cut\n
2) color\n
3) perm\n
4) style\n
    5) trim\n"
    read SERVICE_ID_SELECTED
}

lectura
while ! [[ "$SERVICE_ID_SELECTED" =~ ^[0-9]+$ ]] || ! [ "$SERVICE_ID_SELECTED" -ge 1 ] || ! [ "$SERVICE_ID_SELECTED" -le 5 ]
do
    echo -e "I could not find that service. What would you like today?"
    lectura
done

num



CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" )

if [[ -z $CUSTOMER_NAME ]]
then
    
    echo -e "I don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    insert=$($PSQL "insert into customers (name,phone) values ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    if [[ $insert == 'INSERT 0 1' ]]
    then
        echo "agregado exitosamente"
    else
        echo "error ingresar cliente"
    fi
    
    
fi
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'" )
SERVICE=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED")

echo -e "What time would you like your $SERVICE, $CUSTOMER_NAME?"
read SERVICE_TIME
id_customer=$($PSQL "select customer_id from customers where name='$CUSTOMER_NAME'")
appointments=$($PSQL "insert into  appointments (customer_id,service_id,time) values ($id_customer, $SERVICE_ID_SELECTED , '$SERVICE_TIME')")
if [[ $appointments == 'INSERT 0 1' ]]
then
    echo -e "I have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
else
    echo error fin
fi

