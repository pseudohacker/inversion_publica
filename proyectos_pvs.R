pacman::p_load(readr,
               dplyr,
               tidyr,
               purrr,
               stringr)

data_path <- here::here("input")   # path to the data

#maestro HIS
files <- dir(data_path, pattern = "DETALLE_INVERSIONES.csv") # get file names

dt <- files %>%
  # read in all the files, appending the path before the filename
  map(~ read_csv(file.path(data_path, .)
  )) %>%
  reduce(rbind)

dt_t <- dt |>
  filter(DEPARTAMENTO == "MOQUEGUA") |>
  filter(NIVEL == "GL") |>
  mutate(muni_prio = case_when(str_detect(NOMBRE_UEI, "^GERENCIA") |
                                 str_detect(NOMBRE_UEI, "^UEI DE LA GERENCIA") |
                                 str_detect(NOMBRE_UEI, "SAMEGUA") |
                                 str_detect(NOMBRE_UEI, "PROVINCIAL") |
                                 str_detect(NOMBRE_UEI, "SAN ANTONIO") |
                                 str_detect(NOMBRE_UEI, "PAMPA INALAMBRICA") |
                                 str_detect(NOMBRE_UEI, "TORATA") |
                                 str_detect(NOMBRE_UEI, "MARISCAL NIETO") |
                                 str_detect(NOMBRE_UF, "^GERENCIA") |
                                 str_detect(NOMBRE_UF, "^UEI DE LA GERENCIA") |
                                 str_detect(NOMBRE_UF, "SAMEGUA") |
                                 str_detect(NOMBRE_UF, "PROVINCIAL") |
                                 str_detect(NOMBRE_UF, "SAN ANTONIO") |
                                 str_detect(NOMBRE_UF, "PAMPA INALAMBRICA") |
                                 str_detect(NOMBRE_UF, "TORATA") |
                                 str_detect(NOMBRE_UF, "MARISCAL NIETO") |
                                 str_detect(NOMBRE_UEP, "^GERENCIA") |
                                 str_detect(NOMBRE_UEP, "^UEI DE LA GERENCIA") |
                                 str_detect(NOMBRE_UEP, "SAMEGUA") |
                                 str_detect(NOMBRE_UEP, "PROVINCIAL") |
                                 str_detect(NOMBRE_UEP, "SAN ANTONIO") |
                                 str_detect(NOMBRE_UEP, "PAMPA INALAMBRICA") |
                                 str_detect(NOMBRE_UEP, "TORATA") |
                                 str_detect(NOMBRE_UEP, "MARISCAL NIETO") ~ 1,
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
  select(ENTIDAD,CODIGO_UNICO,CODIGO_SNIP,NOMBRE_INVERSION,ESTADO,SITUACION,MARCO,TIPO_INVERSION,MONTO_VIABLE,
         COSTO_ACTUALIZADO,UBIGEO,LATITUD,LONGITUD,BENEFICIARIO) |>
  group_by(SITUACION, ENTIDAD)

table(dt_t$SITUACION)
dt_t |>dt_t |>dt_t |>
  gt::gt()

write.table(dt_t, file = here::here("output","export_pi.txt"), sep = "|", row.names = FALSE)


      
