<?php

namespace Drupal\akiko\EventSubscriber;

/**
 * Forces automatic redirection of anon users to login form.
 * Thanks to Codim Th for the post "How to redirect anonymous users to login page in drupal 8 & 9"
 * https://codimth.com/blog/web/drupal/how-redirect-anonymous-users-login-page-drupal-8-9
 */

use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\EventDispatcher\Event;


class RedirectAnonymousSubscriber implements EventSubscriberInterface {

  public function __construct() {
    $this->account = \Drupal::currentUser();
  }

  public function checkAuthStatus(Event $event) {

    $allowed = [
      'user.logout',
      'user.register',
      'user.login',
      'user.reset',
      'user.reset.form',
      'user.reset.login',
      'user.login.http',
      'user.logout.http',
      'user.pass'
    ];

    if ( ($this->account->isAnonymous()) && ( !in_array(\Drupal::routeMatch()->getRouteName(), $allowed)) ) {

      // add logic to check other routes you want available to anonymous users,
      // otherwise, redirect to login page.
      $route_name = \Drupal::routeMatch()->getRouteName();
      if (strpos($route_name, 'view') === 0 && strpos($route_name, 'rest_') !== FALSE) {
        return;
      }

      $response = new RedirectResponse('/user/login', 302);
      $response->send();
    }

  }

  public static function getSubscribedEvents() {
    $events[KernelEvents::REQUEST][] = array('checkAuthStatus');
    return $events;
  }

}
