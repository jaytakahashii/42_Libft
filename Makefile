MAKEFILE	= Makefile

NAME		= libft.a

SRC_DIR		= src/
OBJ_DIR		= .obj/

INCLUDE_DIR	= include/
INCLUDE		= -I $(INCLUDE_DIR)
HEADERS		= libft.h \
						get_next_line.h \
						ft_printf.h

DEPS		= $(MAKEFILE) $(HEADERS)

CC			= cc
CFLAGS		= -Wall -Wextra -Werror
PEDANTIC	= --pedantic
SANITIZE	= -fsanitize=address

AR			= ar
ARFLAGS		= rcs

RM			= rm -rf
NORM		= norminette

LIBFT_DIR	= std_libft/

STDLIB_DIR	= stdlib/
STDLIB_SRC	=	ft_atoi.c \
							ft_calloc.c \
							ft_itoa.c \
							ft_abs.c \
							ft_malloc.c

CTYPE_DIR		= ctype/
CTYPE_SRC		=	ft_isalnum.c\
							ft_isalpha.c\
							ft_isascii.c\
							ft_isdigit.c\
							ft_isprint.c\
							ft_isspace.c\
							ft_tolower.c\
							ft_toupper.c\
							pass_space.c

MEM_DIR			= mem/
MEM_SRC			=	ft_bzero.c\
							ft_memchr.c\
							ft_memcmp.c\
							ft_memcpy.c\
							ft_memmove.c\
							ft_memset.c

STR_DIR			= str/
STR_SRC			=	ft_strjoin.c\
							ft_strnstr.c\
							ft_strchr.c\
							ft_strrchr.c\
							ft_strlcat.c\
							ft_strlcpy.c\
							ft_strmapi.c\
							ft_strlen.c\
							ft_strtrim.c\
							ft_substr.c\
							ft_strcmp.c\
							ft_strncmp.c\
							ft_strdup.c\
							ft_split.c\
							ft_striteri.c\
							put_message.c

FD_DIR			= fd/
FD_SRC			=	ft_putchar_fd.c\
							ft_putendl_fd.c\
							ft_putnbr_fd.c\
							ft_putstr_fd.c

LST_DIR			= lst/
LST_SRC			=	ft_lstadd_back.c\
							ft_lstadd_front.c\
							ft_lstclear.c\
							ft_lstdelone.c\
							ft_lstiter.c\
							ft_lstlast.c\
							ft_lstmap.c\
							ft_lstnew.c\
							ft_lstsize.c

ERROR_DIR		= error/
ERROR_SRC		=	error.c

LIBFT_SRC	+= $(addprefix $(STDLIB_DIR), $(STDLIB_SRC))
LIBFT_SRC	+= $(addprefix $(CTYPE_DIR), $(CTYPE_SRC))
LIBFT_SRC	+= $(addprefix $(MEM_DIR), $(MEM_SRC))
LIBFT_SRC	+= $(addprefix $(STR_DIR), $(STR_SRC))
LIBFT_SRC	+= $(addprefix $(FD_DIR), $(FD_SRC))
LIBFT_SRC	+= $(addprefix $(LST_DIR), $(LST_SRC))
LIBFT_SRC += $(addprefix $(ERROR_DIR), $(ERROR_SRC))

GNL_DIR			= gnl/
GNL_SRC			= get_next_line.c \
							get_next_line_utils.c

FTPRINTF_DIR	= ft_printf/
FTPRINTF_SRC	= ft_printf.c \
								output.c \
								print_hex.c \
								print_ptr.c \
								unsigned_itoa.c

SRC_FILES 	+= $(addprefix $(LIBFT_DIR), $(LIBFT_SRC))
SRC_FILES 	+= $(addprefix $(GNL_DIR), $(GNL_SRC))
SRC_FILES 	+= $(addprefix $(FTPRINTF_DIR), $(FTPRINTF_SRC))

OBJ_FILES 	= $(SRC_FILES:%.c=%.o)

SRCS 		= $(addprefix $(SRC_DIR), $(SRC_FILES))
OBJS 		= $(addprefix $(OBJ_DIR), $(OBJ_FILES))

# *****# color ************
Y		= "\033[33m"
R		= "\033[31m"
G		= "\033[32m"
B		= "\033[34m"
X		= "\033[0m"
UP	= "\033[A"
CUT	= "\033[K"
# **************************************************************************

all: ${NAME}

${NAME}: $(OBJ_DIR) ${OBJS}
	@echo $(Y) "$(NAME) src files successfully compiled.\n" $(X)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)
	@echo $(G) "!! $(NAME) created !!" $(X)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@

$(OBJ_DIR):
	@mkdir $(OBJ_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(STDLIB_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(CTYPE_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(MEM_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(STR_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(FD_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(LST_DIR)
	@mkdir $(OBJ_DIR)$(LIBFT_DIR)$(ERROR_DIR)
	@mkdir $(OBJ_DIR)$(GNL_DIR)
	@mkdir $(OBJ_DIR)$(FTPRINTF_DIR)

clean:
	${RM} ${OBJ_DIR}
	@echo $(R) "$(OBJ_DIR) has been removed.\n" $(X)

fclean:
	@${RM} ${OBJ_DIR}
	@${RM} ${NAME}
	@echo $(R) "$(NAME) and $(OBJ_DIR) has been removed.\n" $(X)

re: fclean all

pedantic: CFLAGS += $(PEDANTIC)
pedantic: re
	@echo $(G) "pedantic mode activated.\n" $(X)

leaks: CFLAGS += $(SANITIZE)
leaks: re
	@echo $(G) "leaks mode activated.\n" $(X)

norm:
	@printf $(UP)$(CUT)
	@echo $(R) "<<< $(NAME) error count >>>" $(X)
	@norminette $(SRC_DIR) $(INCLUDE_DIR) | grep Error | grep -v Error! | wc -l
	@norminette $(SRC_DIR) $(INCLUDE_DIR) | grep Error || true

.PHONY : all bonus clean fclean re norm
