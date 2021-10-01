 /**
 * @file
 * AkikoFairTrade theme custom javascript code.
 * Based on Belgrade Theme javascript (web/themes/contrib/belgrade/assets/js/custom_form_elements.js).
  *
  * @author Christophe Espiau
 */
(function ($, Drupal) {

    'use strict';

    /**
     * Close behaviour.
     */
    Drupal.behaviors.quantityIncDec = {
      attach: function (context) {
        $(".number-btn").once().on("click", function() {

            var $button = $(this);
            var oldValue = parseInt($button.parent().find("input").val());
            var newVal;

            // Partie modifiée pour n'obtenir que des nombres pairs.
            if ($button.text() === "+") {
              newVal = oldValue + 2;
            } else {
              // Don't allow decrementing below zero
              newVal = (oldValue > 3) ? oldValue - 2 : 2;
            }
            // Fin de Partie modifiée pour n'obtenir que des nombres pairs.

            $button.parent().find("input").val(newVal);
          });

        // Code ajouté pour obtenir un nombre pair si l'utilisateur saisit manuellement un nombre impair.
        // Décision prise : on ajoute +1 à la valeur impaire saisie.
        // 1 - dans la fiche Produit
        // $(".aft-quantity-adjustment input").once().on("blur", function () {
        //   $(this).val(getEvenValue(Number($(this).val())));
        // });
        // // 2 - dans le shopping bag (volet droit)
        // $(".cart-block--offcanvas-cart-table input").once().on("blur", function () {
        //   $(this).val(getEvenValue(Number($(this).val())));
        // });
        // 3 - dans la page Panier

        function getEvenValue(quantityValue) {
          if (quantityValue%2 != 0) {
            return quantityValue + 1;
          }
          return quantityValue;
        }
      }
    };

  })(jQuery, Drupal);
