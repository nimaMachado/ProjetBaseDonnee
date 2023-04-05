-- Pour Heritages Totals de Subvention

CREATE OR REPLACE FUNCTION Heritage_total__sub_valFix()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Sub_valHab where Sub_valHab.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Subvention can not be fix and by habitant';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__sub_valFix
BEFORE INSERT OR UPDATE ON Sub_valFix
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__sub_valFix();

CREATE OR REPLACE FUNCTION Heritage_total__sub_valHab()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Sub_valFix where Sub_valFix.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Subvention can not be fix and by habitant';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__sub_valHab
BEFORE INSERT OR UPDATE ON Sub_valHab
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__sub_valHab();




CREATE OR REPLACE FUNCTION Heritage_total__Etatique()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Regionale where Regionale.id = NEW.id) OR EXISTS(SELECT id FROM Metropolitaine where Metropolitaine.id = NEW.id) OR EXISTS(SELECT id FROM Communale where Communale.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Subvention can not be applied to several geographical regions';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Etatique
BEFORE INSERT OR UPDATE ON Etatique
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Etatique();

CREATE OR REPLACE FUNCTION Heritage_total__Regionale()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Etatique where Etatique.id = NEW.id) OR EXISTS(SELECT id FROM Metropolitaine where Metropolitaine.id = NEW.id) OR EXISTS(SELECT id FROM Communale where Communale.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Subvention can not be applied to several geographical regions';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Regionale
BEFORE INSERT OR UPDATE ON Regionale
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Regionale() ;

CREATE OR REPLACE FUNCTION Heritage_total__Metropolitaine()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Etatique where Etatique.id = NEW.id) OR EXISTS(SELECT id FROM Regionale where Regionale.id = NEW.id) OR EXISTS(SELECT id FROM Communale where Communale.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Subvention can not be applied to several geographical regions';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Metropolitaine
BEFORE INSERT OR UPDATE ON Metropolitaine
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Metropolitaine();

CREATE OR REPLACE FUNCTION Heritage_total__Communale()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Etatique where Etatique.id = NEW.id) OR EXISTS(SELECT id FROM Metropolitaine where Metropolitaine.id = NEW.id) OR EXISTS(SELECT id FROM Regionale where Regionale.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Subvention can not be applied to several geographical regions';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Communale
BEFORE INSERT OR UPDATE ON Communale
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Communale();


-- Pour Heritage Total de Region_geo


CREATE OR REPLACE FUNCTION Heritage_total__Commune()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Pays where Pays.id = NEW.id) OR EXISTS(SELECT id FROM Metropole where Metropole.id = NEW.id) OR EXISTS(SELECT id FROM Region where Region.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Geographical Regions can not be of several classification';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Commune
BEFORE INSERT OR UPDATE ON Commune
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Commune();

CREATE OR REPLACE FUNCTION Heritage_total__Metropole()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Pays where Pays.id = NEW.id) OR EXISTS(SELECT id FROM Commune where Commune.id = NEW.id) OR EXISTS(SELECT id FROM Region where Region.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Geographical Regions can not be of several classification';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Metropole
BEFORE INSERT OR UPDATE ON Metropole
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Metropole();

CREATE OR REPLACE FUNCTION Heritage_total__Region()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Pays where Pays.id = NEW.id) OR EXISTS(SELECT id FROM Metropole where Metropole.id = NEW.id) OR EXISTS(SELECT id FROM Commune where Commune.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Geographical Regions can not be of several classification';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Region
BEFORE INSERT OR UPDATE ON Region
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Region();

CREATE OR REPLACE FUNCTION Heritage_total__Pays()
RETURNS trigger
AS
$$
    BEGIN
        IF EXISTS(SELECT id FROM Commune where Commune.id = NEW.id) OR EXISTS(SELECT id FROM Metropole where Metropole.id = NEW.id) OR EXISTS(SELECT id FROM Region where Region.id = NEW.id)
            THEN 
                RAISE EXCEPTION 'Geographical Regions can not be of several classification';
        END IF;
    END;
$$
LANGUAGE plpgsql ;

CREATE OR REPLACE TRIGGER Heritage_total__Pays
BEFORE INSERT OR UPDATE ON Pays
FOR EACH ROW
EXECUTE PROCEDURE Heritage_total__Pays();


-- Pour Heritage Totale Liquide

