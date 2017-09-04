omnirom_soong:
	$(hide) mkdir -p $(dir $@)
	$(hide) (\
	echo '{'; \
	echo '"Omnirom": {'; \
	echo '},'; \
	echo '') > $(SOONG_VARIABLES_TMP)
