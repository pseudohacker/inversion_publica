pacman::p_load(dplyr,
               stringr)
dt_t <- dt_cierre |>
  filter(DEPARTAMENTO == "MOQUEGUA") |>
  filter(NIVEL == "GL") |>
  mutate(muni_prio = case_when(str_detect(NOM_UEI, "^GERENCIA") |
                                 str_detect(NOM_UEI, "^UEI DE LA GERENCIA") |
                                 str_detect(NOM_UEI, "SAMEGUA") |
                                 str_detect(NOM_UEI, "PROVINCIAL") |
                                 str_detect(NOM_UEI, "SAN ANTONIO") |
                                 str_detect(NOM_UEI, "PAMPA INALAMBRICA") |
                                 str_detect(NOM_UEI, "TORATA") |
                                 str_detect(NOM_UEI, "MARISCAL NIETO") |
                                 str_detect(NOM_UF, "^GERENCIA") |
                                 str_detect(NOM_UF, "^UEI DE LA GERENCIA") |
                                 str_detect(NOM_UF, "SAMEGUA") |
                                 str_detect(NOM_UF, "PROVINCIAL") |
                                 str_detect(NOM_UF, "SAN ANTONIO") |
                                 str_detect(NOM_UF, "PAMPA INALAMBRICA") |
                                 str_detect(NOM_UF, "TORATA") |
                                 str_detect(NOM_UF, "MARISCAL NIETO") |
                                 str_detect(NOM_UEP, "^GERENCIA") |
                                 str_detect(NOM_UEP, "^UEI DE LA GERENCIA") |
                                 str_detect(NOM_UEP, "SAMEGUA") |
                                 str_detect(NOM_UEP, "PROVINCIAL") |
                                 str_detect(NOM_UEP, "SAN ANTONIO") |
                                 str_detect(NOM_UEP, "PAMPA INALAMBRICA") |
                                 str_detect(NOM_UEP, "TORATA") |
                                 str_detect(NOM_UEP, "MARISCAL NIETO") ~ 1,
                               TRUE ~ 0)) |>
  filter(muni_prio == 1) |>
  mutate(proy_prio = case_when(str_detect(NOMBRE_INVERSION, "PARQUE") |
                                 str_detect(NOMBRE_INVERSION, "CENTRO COMUNAL") |
                                 str_detect(NOMBRE_INVERSION, "PLAZA") |
                                 str_detect(NOMBRE_INVERSION, "DEPORT") |
                                 str_detect(NOMBRE_INVERSION, "RECRE") |
                                 str_detect(NOMBRE_INVERSION, "MALECON") |
                                 str_detect(NOMBRE_INVERSION, "PEATONAL") |
                                 str_detect(NOMBRE_INVERSION, "MOVILIDAD URBANA") |
                                 str_detect(NOMBRE_INVERSION, "VIVERO") |
                                 str_detect(NOMBRE_INVERSION, "INTERURBAN") |
                                 str_detect(NOMBRE_INVERSION, "BERMA") ~ 1,
                               TRUE ~ 0)) |>
  filter(proy_prio == 1) |>
  filter(CULMINADA == "SÍ") |>
  mutate(ANHO = format(FEC_CIERRE, "%Y"))
  # select(ENTIDAD,CODIGO_UNICO,CODIGO_SNIP,NOMBRE_INVERSION,ESTADO,SITUACION,MARCO,TIPO_INVERSION,MONTO_VIABLE,
  #        COSTO_ACTUALIZADO,UBIGEO,LATITUD,LONGITUD,BENEFICIARIO) |>
  # group_by(SITUACION, ENTIDAD)
table(dt_t$ANHO)

dt_t |>  
  rio::export(here::here("output","result_final.xlsx"),format = "xlsx")



