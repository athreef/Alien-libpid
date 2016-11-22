use Test::More;
use Test::Alien 0.05;
use Alien::libpid;

alien_ok 'Alien::libpid';
my $xs = do { local $/; <DATA> };
xs_ok $xs, with_subtest {
    my($module) = @_;
    is $module->xs_pid_self, $$, "Getting own pid";
    is $module->xs_pid_parent, getppid, "Getting parent pid";
};

done_testing;

__DATA__

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <pid.h>

/* using unsigned long for portability */

unsigned long xs_pid_self(const char *s) {
    (void)s;
    return pid_self();
}
unsigned long xs_pid_parent(const char *s) {
    (void)s;
    return pid_parent();
}

MODULE = TA_MODULE PACKAGE = TA_MODULE

unsigned long xs_pid_self(class);
 const char *class;

unsigned long xs_pid_parent(class);
 const char *class;

