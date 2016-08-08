include config.mk


.PHONY : ocd_ctrl_socket
ocd_ctrl_socket :
	ssh -M -S $@ -fnNT -L $(PG_PORT):$(PG_HOST):5432 ubuntu@ocd.datamade.us

.PHONY : clean
clean : ocd_ctrl_socket
	ssh -S ocd_ctrl_socket -O exit ubuntu@ocd.datamade.us

.PHONY : interactive
interactive : ocd_ctrl_socket
	psql -h $(PG_HOST) -p $(PG_PORT) -d $(PG_DB) -U $(PG_USER)


released.csv : ocd_ctrl_socket
	psql -h $(PG_HOST) -p $(PG_PORT) -d $(PG_DB) -U $(PG_USER) -c \
	"copy (select * from arrest left join arrest_event using (arrest_event_id) inner join arrestee using (arrest_id) left join arrestee_address using(arrest_id) left join bond using (arrest_id) left join arrest_charges using (arrest_id) inner join charges using (charge_code) left join lockup using (arrest_id) where released between '2016-07-04'::DATE and '2016-07-17'::DATE) TO STDOUT WITH CSV HEADER" > $@
